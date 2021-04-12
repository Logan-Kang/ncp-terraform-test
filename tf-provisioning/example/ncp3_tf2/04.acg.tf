resource "ncloud_access_control_group" "acg" {
  name        = "tf-web-acg"
  vpc_no      = ncloud_vpc.vpc.id
}

locals {
  tf-web-acg-inbound = [
    ["TCP", "0.0.0.0/0", "22", "SSH", ""],
    ["TCP", "0.0.0.0/0", "80", "HTTP", ""],
    ["TCP", "0.0.0.0/0", "3389", "RDP", ""],
    ["ICMP", "0.0.0.0/0", null, "ICMP", ""],
    ["TCP", "0.0.0.0/0", "3306", "MySQL", ""],
    ["TCP", "0.0.0.0/0", "8080", "WAS", ""],
    ["TCP", "0.0.0.0/0", "8009", "TOMCAT", ""],
    ["TCP", ncloud_subnet.pub_subnet.subnet, "1-65535", "inTraffic", ""],
  ]

  tf-web-acg-outbound = [
    ["TCP", "0.0.0.0/0", "1-65535", "TCP all", ""],
    ["UDP", "0.0.0.0/0", "1-65535", "UDP all", ""],
  ]
}


resource "ncloud_access_control_group_rule" "acg-rule" {
  access_control_group_no = ncloud_access_control_group.acg.id

  dynamic "inbound" {
    for_each = local.tf-web-acg-inbound
    content {
      protocol = inbound.value[0]
      ip_block = inbound.value[1]
      port_range = inbound.value[2]
      description = inbound.value[3]
      source_access_control_group_no = inbound.value[4]
    }
  }
  dynamic "outbound" {
    for_each = local.tf-web-acg-outbound
    content {
      protocol = outbound.value[0]
      ip_block = outbound.value[1]
      port_range = outbound.value[2]
      description = outbound.value[3]
      source_access_control_group_no = outbound.value[4]
    }
  }
/*
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
    description = "SSH"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
    description = "HTTP"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "8080"
    description = "WAS"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "8009"
    description = "WAS"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "3389"
    description = "RDP"
  }

  inbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0"
    port_range  = "3306"
    description = "MYSQL"
  }
  inbound {
    protocol    = "ICMP"
    ip_block    = "0.0.0.0/0"
    description = "ICMP"
  }
  inbound {
    protocol    = "TCP"
    ip_block    = "10.20.1.0/24"
    port_range  = "1-65535"
    description = ""
  }

  outbound {
    protocol    = "TCP"
    ip_block    = "0.0.0.0/0" 
    port_range  = "1-65535"
    description = "TCP all"
  }

  outbound {
    protocol    = "UDP"
    ip_block    = "0.0.0.0/0" 
    port_range  = "1-65535"
    description = "UDP all"
  }
  */
}