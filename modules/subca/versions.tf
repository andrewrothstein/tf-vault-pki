terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 2.12.2"
    }
  }
  required_version = ">= 0.13"
}
