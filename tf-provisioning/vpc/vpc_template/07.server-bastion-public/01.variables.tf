variable "access_key" {}

variable "secret_key" {}

variable "site" {
    # default = "public" # : Public
    # default = "gov" #: Gov
    # default = "fin" #: Finance
}

variable "account_name" {}

variable "vpc_num" {}

variable "region" {}

variable "support_vpc" {
  type = bool
}

variable "pub_subnet_cidr" {}

variable "inbound_acg" {
  type = list
}
variable "outbound_acg" {
  type = list
}

variable "linux_password" {}

variable "server_spec_bastion" {}

variable "server_image_bastion" {}

variable "init_script_bastion" {}