variable "access_key" {}

variable "secret_key" {}

variable "region" {
    default = "KR"
}

variable "site" {
    default = "public" # : Public
    #default = "gov" #: Gov
    # default = "fin" #: Finance
}

variable "support_vpc" {}