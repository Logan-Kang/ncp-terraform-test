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

variable "server_spec_exechost" {}

variable "server_image_exechost" {}

variable "lb_name" {}

variable "lb_network_type" {}

variable "lb_type" {}

variable "listener_protocol" {}

variable "listener_port" {}

variable "tg_protocol" {}

variable "tg_port" {}

variable "hc_protocol" {}

variable "hc_port" {}

variable "hc_url" {}

variable "use_sticky_session" {
  type = bool
}

variable "use_proxy_protocol" {
  type = bool
}