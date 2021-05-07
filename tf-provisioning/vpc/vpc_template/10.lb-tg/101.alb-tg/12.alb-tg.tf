data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_server" "tester-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-tester-server"]
  }
}

## make target group for application loadbalancer
resource "ncloud_lb_target_group" "alb-tg" {
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-alb-tg"
  protocol = "HTTP"
  target_type = "VSVR"
  port        = 80
  description = "for test"
  health_check {
    protocol = "HTTP"
    http_method = "GET"
    port           = 80
    url_path       = "/index.html"
    cycle          = 30
    up_threshold   = 2
    down_threshold = 2
  }
  algorithm_type = "RR"

}

## attach server in target group(plural)
resource "ncloud_lb_target_group_attachment" "alb-tg-instance" {
  target_group_no = ncloud_lb_target_group.alb-tg.target_group_no
  target_no_list = [data.ncloud_server.tester-server.instance_no]

}