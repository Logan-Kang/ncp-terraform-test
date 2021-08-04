terraform {
  required_providers {
    ncloud = {
      source = "navercloudplatform/ncloud"
    }
    random = {
      source = "hashicorp/random"
    }
  }
  required_version = ">= 0.13"
}
