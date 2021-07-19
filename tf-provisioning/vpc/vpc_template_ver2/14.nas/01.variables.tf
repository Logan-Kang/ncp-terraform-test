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

variable "server_spec_exechost" {}

variable "server_image_exechost" {}

variable "nas_name_postfix" {}

variable "nas_size" {}

variable "nas_protocol" {}

variable "cifs_user_name" {}

variable "cifs_user_password" {}

variable "nas_encrypted" {
  type = bool
}