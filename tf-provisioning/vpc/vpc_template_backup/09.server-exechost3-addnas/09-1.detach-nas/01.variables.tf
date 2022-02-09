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

variable "linux_password" {}

variable "num_of_exechost3" {}