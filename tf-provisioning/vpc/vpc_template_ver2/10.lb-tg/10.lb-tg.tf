data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_server" "exechost-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost-server"]
  }
}

## make target group for application loadbalancer
resource "ncloud_lb_target_group" "lb-tg" {
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-tg"
  protocol = var.tg_protocol
  target_type = "VSVR"
  port        = var.tg_port
  description = "for test"
  health_check {
    protocol = var.hc_protocol
    http_method = "GET"
    port           = var.hc_port
    url_path       = var.hc_url
    cycle          = 30
    up_threshold   = 2
    down_threshold = 2
  }
  algorithm_type = "RR"
  use_sticky_session = var.use_sticky_session
  use_proxy_protocol = var.use_proxy_protocol

}

## attach server in target group(plural)
resource "ncloud_lb_target_group_attachment" "lb-tg-instance" {
  target_group_no = ncloud_lb_target_group.lb-tg.target_group_no
  target_no_list = [data.ncloud_server.exechost-server.instance_no]

}