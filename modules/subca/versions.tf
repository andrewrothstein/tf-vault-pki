terraform {
  backend "s3" {}
  required_providers {
    vault = {
      source = "hashicorp/vault"
     version = "~> 2.18.0"
    }
  }
  required_version = ">= 0.14"
}
