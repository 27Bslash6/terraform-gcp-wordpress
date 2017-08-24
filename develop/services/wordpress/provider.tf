variable "gcp_project" {}
variable "gcp_credentials" {}
variable "gcp_region" {}

# Configure the Google Cloud provider
provider "google" {
  credentials = "${file("${var.gcp_credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.gcp_region}"
}
