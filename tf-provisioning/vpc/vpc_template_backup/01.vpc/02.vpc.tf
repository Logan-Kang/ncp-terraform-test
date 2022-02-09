resource "ncloud_vpc" "vpc" {
    name = "tf-${var.account_name}-vpc${var.vpc_num}"
    ipv4_cidr_block = var.vpc_cidr
}
