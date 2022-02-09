data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

## make NAT Gateway
# NAT Gateway의 경우 zone당 1개씩 구성이 가능하나,
# 실질적으로 사용을 위해서는 private route table 당 1개만 연결함.(zone1)

resource "ncloud_nat_gateway" "nat_gateway_zone1" {
  vpc_no      = data.ncloud_vpc.vpc.id
  zone        = var.zone[0]
  name        = "${data.ncloud_vpc.vpc.name}-natgw01"
}
resource "ncloud_nat_gateway" "nat_gateway_zone2" {
  vpc_no      = data.ncloud_vpc.vpc.id
  zone        = var.zone[1]
  name        = "${data.ncloud_vpc.vpc.name}-natgw02"
}

data "ncloud_route_table" "priv-subnet-route-table" {
  vpc_no                = data.ncloud_vpc.vpc.id
  supported_subnet_type = "PRIVATE"
  filter {
    name = "is_default"
    values = [true]
  }
}

## add route table about NAT Gateway
resource "ncloud_route" "add-natgw-zone1" {
  route_table_no         = data.ncloud_route_table.priv-subnet-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  target_type            = "NATGW"
  target_name            = ncloud_nat_gateway.nat_gateway_zone1.name
  target_no              = ncloud_nat_gateway.nat_gateway_zone1.id
}

/*
resource "ncloud_route" "add-natgw-zone2" {
  route_table_no         = data.ncloud_route_table.priv-subnet-route-table.id
  destination_cidr_block = "128.0.0.0/1"
  target_type            = "NATGW"
  target_name            = ncloud_nat_gateway.nat_gateway_zone2.name
  target_no              = ncloud_nat_gateway.nat_gateway_zone2.id
}
*/