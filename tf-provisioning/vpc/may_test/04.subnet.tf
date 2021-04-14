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

resource "ncloud_subnet" "priv_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = var.priv_subnet_cidr
  zone           = var.zone
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "${ncloud_vpc.vpc.name}-priv-subnet"
  usage_type     = "GEN"    // GEN(General) | LOADB(For load balancer)
}

/*resource "ncloud_subnet" "lb_subnet" {
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.20.253.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.nacl.id
  subnet_type    = "PRIVATE" // PUBLIC | PRIVATE
  // below fields is optional
  name           = "tf-lb-subnet"
  usage_type     = "LOADB"    // GEN(General) | LOADB(For load balancer)
}*/ 