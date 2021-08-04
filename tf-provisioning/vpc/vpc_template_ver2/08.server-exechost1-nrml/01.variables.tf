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

variable "exechost1_priv_subnet" {}

variable "num_of_exechost1" {}

variable "init_script_exechost1" {}

variable "linux_password" {}

variable "server_spec_exechost1" {}

variable "server_image_exechost1" {}
