data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_network_acls" "nacls" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-nacl-default"
}

resource "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.pub_subnet_cidr
  zone           = var.zone
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PUBLIC" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-pub-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

resource "ncloud_subnet" "vpc_priv_subnet" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.priv_subnet_cidr
  zone           = var.zone
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-priv-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_pub_subnet
  ]
}

resource "ncloud_subnet" "vpc_priv_subnet2" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.priv_subnet2_cidr
  zone           = var.zone2
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-priv-subnet2"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_pub_subnet
  ]
}

resource "ncloud_subnet" "vpc_lb_subnet" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.lb_subnet_cidr
  zone           = var.zone
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-lb-subnet"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_priv_subnet
  ]
}
