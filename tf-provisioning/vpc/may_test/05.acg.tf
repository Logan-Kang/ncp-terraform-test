resource "ncloud_access_control_group" "acg" {
  name        = "${ncloud_vpc.vpc.name}-acg"
  vpc_no      = ncloud_vpc.vpc.id
}
locals {
  count = length(var.inbound_acg)
  tf-default-acg-inbound = [
    var.inbound_acg[0],
    var.inbound_acg[1],
    var.inbound_acg[2],
    var.inbound_acg[3],
  ]

  tf-default-acg-outbound = [
    var.outbound_acg[0],
    var.outbound_acg[1],
    var.outbound_acg[2],
  ]
}


resource "ncloud_access_control_group_rule" "acg-rule" {
  #count = var.acg_rule_num
  access_control_group_no = ncloud_access_control_group.acg.id

  dynamic "inbound" {
    for_each = local.tf-default-acg-inbound
    content {
      protocol = inbound.value[0]
      ip_block = inbound.value[1]
      port_range = inbound.value[2]
      description = inbound.value[3]
      source_access_control_group_no = inbound.value[4]
    }
  }
  dynamic "outbound" {
    for_each = local.tf-default-acg-outbound
    content {
      protocol = outbound.value[0]
      ip_block = outbound.value[1]
      port_range = outbound.value[2]
      description = outbound.value[3]
      source_access_control_group_no = outbound.value[4]
    }
  }
}
/*
resource "ncloud_access_control_group_rule" "acg-rule" {
  count = var.acg_num
  access_control_group_no = ncloud_access_control_group.acg.id

  inbound {
    protocol    = var.acg_protocol[count.index]
    ip_block    = var.acg_ip_range[count.index]
    port_range  = var.acg_port_range[count.index]
    description = var.acg_description[count.index]
  }
  /*
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
}
*/