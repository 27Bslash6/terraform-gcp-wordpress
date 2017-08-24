variable "sql_instance_name" {}
variable "redis_cluster_name" {}
variable "wordpress_cluster_name" {}

variable "cluster_master_username" {}
variable "cluster_master_password" {}

module "cloudsql" {
  source = "git::https://github.com/27Bslash6/terraform-gcp-cloudsql.git?ref=master"

  # source = "../../../../terraform-gcp-cloudsql"

  cloudsql_master_name = "${var.sql_instance_name}"
  cloudsql_username = "wordpress"
  cloudsql_userpass = "thisisnotapassword"
}

module "redis" {
  source = "git::https://github.com/27Bslash6/terraform-gke.git?ref=master"

  # source = "../../../../terraform-gke"

  cluster_name        = "${var.redis_cluster_name}"
  initial_node_count  = 1
  machine_type        = "f1-micro"
  disk_size_gb        = "10"
  gcp_master_username = "${var.cluster_master_username}"
  gcp_master_password = "${var.cluster_master_password}"
  gcp_primary_zone    = "${var.gcp_region}-a"
  gcp_additional_zones = [
    "${var.gcp_region}-b",
    "${var.gcp_region}-c",
  ]
  custom_provisioner = <<EOF
helm init && \
sleep 10 && \
helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/ && \
sync && sleep 10 && \
helm install -n p4-redis incubator/redis-cache
EOF
}

module "wordpress" {
  source = "git::https://github.com/27Bslash6/terraform-gke.git?ref=master"

  # source = "../../../../terraform-gke"

  cluster_name        = "${var.wordpress_cluster_name}"
  initial_node_count  = 1
  machine_type        = "g1-small"
  disk_size_gb        = "10"
  gcp_master_username = "${var.cluster_master_username}"
  gcp_master_password = "${var.cluster_master_password}"
  gcp_primary_zone    = "${var.gcp_region}-a"
  gcp_additional_zones = [
    "${var.gcp_region}-b",
  ]

  # @todo Install Helm provider:
  # https://github.com/mcuadros/terraform-provider-helm/blob/master/docs/index.html.md

  custom_provisioner = <<EOF
gcloud sql users create proxyuser cloudsqlproxy~% --instance=${var.sql_instance_name} && \
helm init && \
sleep 10 && \
helm install --name p4-app stable/wordpress
EOF
}
