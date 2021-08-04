data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_network_acls" "nacls" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-nacl-default"
}

resource "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.pub_subnet_cidr
  zone           = var.zone[0]
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PUBLIC" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-pub-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

resource "ncloud_subnet" "vpc_priv_subnet" {
  count = var.num_of_priv_subnets
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.priv_subnet_cidr[count.index]
  zone           = var.zone[count.index]
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-priv-subnet${count.index+1}"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_pub_subnet
  ]
}

resource "ncloud_subnet" "vpc_lb_subnet" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.lb_subnet_cidr[0]
  zone           = var.zone[0]
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-lb-subnet1"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_priv_subnet
  ]
}

resource "ncloud_subnet" "vpc_lb_subnet2" {
  vpc_no         = data.ncloud_vpc.vpc.id
  subnet         = var.lb_subnet_cidr[1]
  zone           = var.zone[1]
  network_acl_no = data.ncloud_network_acls.nacls.network_acls[0].id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${data.ncloud_vpc.vpc.name}-lb-subnet2"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_priv_subnet
  ]
}