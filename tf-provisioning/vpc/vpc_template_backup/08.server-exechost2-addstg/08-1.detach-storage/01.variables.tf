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

variable "exechost2_priv_subnet" {}

variable "num_of_exechost2" {}

variable "server_spec_exechost2" {}

variable "server_image_exechost2" {}

variable "init_script_exechost2" {}

variable "exechost2_addstg_size" {}

variable "exechost2_addstg_mountdir" {}