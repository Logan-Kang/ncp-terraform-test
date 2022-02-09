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

variable "mysql_priv_subnet" {}

variable "cdbmysql_name" {}

variable "cdbmysql_prefix" {}

variable "cdbmysql_username" {}

variable "cdbmysql_userpwd" {}

variable "cdbmysql_hostIP" {}

variable "cdbmysql_dbname" {}

variable "path_module" {}

variable "api_url" {}


