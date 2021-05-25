provider "ncloud" {
  access_key  = var.access_key
  secret_key  = var.secret_key
  region      = "FKR"
  site        = var.site
  support_vpc = true
}
