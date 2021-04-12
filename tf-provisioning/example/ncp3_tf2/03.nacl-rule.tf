resource "ncloud_network_acl" "nacl" {
  vpc_no = ncloud_vpc.vpc.id
  name = "tf-vpc-nacl"
}

resource "ncloud_network_acl_rule" "nacl_rule" {
  depends_on = [ncloud_network_acl.nacl]
  network_acl_no    = ncloud_network_acl.nacl.id

  inbound {                     // SSH
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "22"
  }

  inbound {                     // HTTP
    priority    = 110
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "80"
  }

  inbound {                     // RDP
    priority    = 120
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "3389"
  }

  inbound {                     // ICMP
    priority    = 130
    protocol    = "ICMP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
  }

  outbound {                    // Outbound TCP all
    priority    = 100
    protocol    = "TCP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

  outbound {                    // Outbound UDP all
    priority    = 110
    protocol    = "UDP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
    port_range  = "1-65535"
  }

  outbound {                    // Outbound ICMP all
    priority    = 120
    protocol    = "ICMP"
    rule_action = "ALLOW"
    ip_block    = "0.0.0.0/0"
  }
}