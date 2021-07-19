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

variable "zone" {}

variable "pub_subnet_cidr" {}

variable "priv_subnet_cidr" {}

variable "priv_subnet2_cidr" {}

variable "lb_subnet_cidr" {}

variable "inbound_acg" {
  type = list
}
variable "outbound_acg" {
  type = list
}

variable "num_of_svrs" {}

variable "init_script_name" {}

variable "linux_password" {}

variable "server_spec_exechost2" {}

variable "server_image_exechost2" {}
