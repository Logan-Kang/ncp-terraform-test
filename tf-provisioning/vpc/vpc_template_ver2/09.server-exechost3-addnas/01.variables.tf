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

variable "exechost3_priv_subnet" {}

variable "num_of_exechost3" {}

variable "server_spec_exechost3" {}

variable "server_image_exechost3" {}

variable "init_script_exechost3" {}

variable "exechost3_nas_name_postfix" {}

variable "exechost3_nas_size" {}

variable "exechost3_nas_protocol" {}

variable "exechost3_cifs_user_name" {}

variable "exechost3_cifs_user_password" {}

variable "exechost3_nas_encrypted" {
  type = bool
}

variable "exechost3_nas_mountdir" {}