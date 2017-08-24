terraform {
  backend "gcs" {
    bucket = "planet-4-151612-terraform-admin"
    path   = "develop/terraform.state"
  }
}
