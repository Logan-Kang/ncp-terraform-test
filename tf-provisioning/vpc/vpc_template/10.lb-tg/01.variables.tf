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

## target group - exechost1
variable "tg_protocol_exechost1" {}
variable "tg_port_exechost1" {}
variable "hc_protocol_exechost1" {}
variable "hc_port_exechost1" {}
variable "hc_url_exechost1" {}

## target group - exechost2
variable "tg_protocol_exechost2" {}
variable "tg_port_exechost2" {}
variable "hc_protocol_exechost2" {}
variable "hc_port_exechost2" {}
variable "hc_url_exechost2" {}

## target group - exechost1
variable "tg_protocol_exechost3" {}
variable "tg_port_exechost3" {}
variable "hc_protocol_exechost3" {}
variable "hc_port_exechost3" {}
variable "hc_url_exechost3" {}

variable "use_sticky_session" {
  type = bool
}

variable "use_proxy_protocol" {
  type = bool
}