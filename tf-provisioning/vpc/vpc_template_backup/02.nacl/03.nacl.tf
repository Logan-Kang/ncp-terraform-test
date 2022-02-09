data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

resource "ncloud_network_acl" "nacl" {
  vpc_no = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-nacl-default"
}

# ACG 관리 중점 진행으로 nacl rule을 별도로 설정하지 않음(필요시 구성 예정)
/*
locals {
  default-nacl-inbound = [
    [100,"TCP", "ALLOW","0.0.0.0/0", "22"],
    [110,"TCP", "ALLOW","0.0.0.0/0", "80"],
    [120,"TCP", "ALLOW","0.0.0.0/0", "3389"],
    [130,"ICMP", "ALLOW","0.0.0.0/0", ""],
  ]

  default-nacl-outbound = [
    [100,"TCP", "ALLOW","0.0.0.0/0", "1-65535"],
    [110,"UDP", "ALLOW","0.0.0.0/0", "1-65535"],
    [120,"ICMP", "ALLOW","0.0.0.0/0", ""],
  ]
}

resource "ncloud_network_acl_rule" "nacl_rule" {
  depends_on = [ncloud_network_acl.nacl]
  network_acl_no    = ncloud_network_acl.nacl.id

  dynamic "inbound" {
    for_each = local.default-nacl-inbound
    content {
      priority    = inbound.value[0]
      protocol    = inbound.value[1]
      rule_action = inbound.value[2]
      ip_block    = inbound.value[3]
      port_range  = inbound.value[4]
    }
  }
  dynamic "outbound" {
    for_each = local.default-nacl-outbound
    content {
      priority    = outbound.value[0]
      protocol    = outbound.value[1]
      rule_action = outbound.value[2]
      ip_block    = outbound.value[3]
      port_range  = outbound.value[4]
    }
  }
}
*/