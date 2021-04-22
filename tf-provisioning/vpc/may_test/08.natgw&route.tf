## make NAT Gateway
resource "ncloud_nat_gateway" "nat_gateway" {
  vpc_no      = ncloud_vpc.vpc.id
  zone        = var.zone
  name        = "${ncloud_vpc.vpc.name}-natgw"
  depends_on = [
    ncloud_subnet.vpc_priv_subnet
  ]
}

data "ncloud_route_table" "priv-subnet-default" {
  vpc_no                = ncloud_vpc.vpc.id
  supported_subnet_type = "PRIVATE"
  filter {
    name = "is_default"
    values = ["true"]
  }
}
## add route table about NAT Gateway
resource "ncloud_route" "add-natgw" {
  route_table_no         = data.ncloud_route_table.priv-subnet-default.id
  destination_cidr_block = "0.0.0.0/0"
  target_type            = "NATGW"
  target_name            = ncloud_nat_gateway.nat_gateway.name
  target_no              = ncloud_nat_gateway.nat_gateway.id
}