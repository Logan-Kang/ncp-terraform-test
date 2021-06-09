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

variable "inbound_acg" {
  type = list
}
variable "outbound_acg" {
  type = list
}

variable "linux_password" {}

variable "server_spec_bastion" {}

variable "server_image_bastion" {}

variable "cdbmysql_name" {}

variable "cdbmysql_prefix" {}

variable "cdbmysql_username" {}

variable "cdbmysql_userpwd" {}

variable "cdbmysql_hostIP" {}

variable "cdbmysql_dbname" {}

variable "path_module" {}

variable "api_url" {}


