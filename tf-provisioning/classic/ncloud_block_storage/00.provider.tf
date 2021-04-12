provider "ncloud" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "KR"
  site        = var.site
  support_vpc = false
}

variable "access_key" {}

variable "secret_key" {}

variable "site" {
    # default = "public" # : Public
    # default = "gov" #: Gov
    # default = "fin" #: Finance
}