resource "ncloud_vpc" "vpc" {
    name = "tf-${var.account_name}-vpc-${random_string.prefix.result}"
    ipv4_cidr_block = var.vpc_cidr
}
