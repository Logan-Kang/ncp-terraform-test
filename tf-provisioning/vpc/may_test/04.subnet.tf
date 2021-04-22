resource "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.pub_subnet_cidr
  zone           = var.zone
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = "PUBLIC" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${ncloud_vpc.vpc.name}-pub-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

resource "ncloud_subnet" "vpc_priv_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.priv_subnet_cidr
  zone           = var.zone
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${ncloud_vpc.vpc.name}-priv-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_pub_subnet
  ]
}

resource "ncloud_subnet" "vpc_lb_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.lb_subnet_cidr
  zone           = var.zone
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${ncloud_vpc.vpc.name}-lb-subnet"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
  depends_on = [
    ncloud_subnet.vpc_priv_subnet
  ]
}