provider "aws" {
  alias      = "hub_2_VPC"
  region     = var.virginia_region
  access_key = var.access_key
  secret_key = var.secret_key
}