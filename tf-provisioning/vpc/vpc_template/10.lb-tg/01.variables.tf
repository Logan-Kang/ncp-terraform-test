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

variable "num_of_exechost1" {}
variable "num_of_exechost2" {}
variable "num_of_exechost3" {}


variable "lb_name" {}

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