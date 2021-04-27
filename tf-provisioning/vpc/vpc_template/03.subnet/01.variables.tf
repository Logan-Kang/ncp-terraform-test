variable "access_key" {}

variable "secret_key" {}

variable "site" {
    # default = "public" # : Public
    # default = "gov" #: Gov
    # default = "fin" #: Finance
}

variable "account_name" {}

variable "vpc_num" {}

variable "zone" {}

variable "pub_subnet_cidr" {}

variable "priv_subnet_cidr" {}

variable "lb_subnet_cidr" {}


/*
resource "random_string" "prefix" {
  length  = 3
  special = false
  upper   = false
  number  = false
}*/