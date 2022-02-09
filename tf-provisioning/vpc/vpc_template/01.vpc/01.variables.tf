variable "access_key" {}

variable "secret_key" {}

variable "site" {
    # default = "public" # : Public
    # default = "gov" #: Gov
    # default = "fin" #: Finance
}

variable "account_name" {}


variable "region" {}

variable "support_vpc" {
  type = bool
}

variable "zone" {}

variable "vpc_num" {}
/*resource "random_string" "prefix" {
  length  = 3
  special = false
  upper   = false
  number  = false
}*/

variable "vpc_cidr" {}

