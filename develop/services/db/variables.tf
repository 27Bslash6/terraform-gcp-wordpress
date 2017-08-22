# https://www.terraform.io/docs/providers/google/r/sql_database_instance.html

variable "gcp_project" {
  description = "Name of the Google Compute project to use"
}

variable "gcp_credentials" {
  description = "Credentials file to use for accessing Google Compute resources"
}

variable "gcp_region" {
  description = "Google Compute region to use for the cluster"
  default     = "us-west1"
}

# Cloud SQL variables

# Main configuration
variable "cloudsql_master_name" {
  description = "Name of the CloudSQL master server"
}

variable "cloudsql_version" {
  description = "The MySQL version to use. Can be MYSQL_5_6, MYSQL_5_7 or POSTGRES_9_6 for second-generation instances, or MYSQL_5_5 or MYSQL_5_6 for first-generation instances."
  default     = "MYSQL_5_7"
}

# Cloud SQL settings
variable "cloudsql_tier" {
  description = "The machine tier (First Generation) or type (Second Generation) to use. See tiers for more details and supported versions. Postgres supports only shared-core machine types such as db-f1-micro, and custom machine types such as db-custom-2-13312."
  default     = "db-f1-micro"
}

variable "disk_size" {
  description = " (Optional, Second Generation, Default: 10) The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  default     = "10"
}

variable "disk_type" {
  description = "(Optional, Second Generation, Default: PD_SSD) The type of data disk: PD_SSD or PD_HDD"
  default     = "PD_SSD"
}

variable "backup_enabled" {
  default = true
}

variable "backup_start_time" {
  default = "18:00"
}

variable "master_location_preference_zone" {
  default = "us-west1-a"
}

variable "failover_location_preference_zone" {
  description = ""
  default     = "us-west1-b"
}
