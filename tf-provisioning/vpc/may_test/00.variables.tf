variable "access_key" {}

variable "secret_key" {}

variable "site" {
    # default = "public" # : Public
    # default = "gov" #: Gov
    # default = "fin" #: Finance
}

variable "account_name" {}

variable "zone" {}

variable "imagecode" {}

variable "speccode" {}

variable "num" {}

resource "random_string" "prefix" {
  length  = 3
  special = false
  upper   = false
  number  = false
}

variable "vpc_cidr" {}

variable "pub_subnet_cidr" {}

variable "priv_subnet_cidr" {}