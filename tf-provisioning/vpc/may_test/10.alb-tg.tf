## make target group for application loadbalancer
resource "ncloud_lb_target_group" "alb-tg" {
  vpc_no   = ncloud_vpc.vpc.id
  name = "${ncloud_vpc.vpc.name}-alb-tg"
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

  depends_on = [
      ncloud_subnet.vpc_lb_subnet,
      ncloud_server.tester-server
  ]
}

## attach server in target group(plural)
resource "ncloud_lb_target_group_attachment" "alb-tg-instance" {
  target_group_no = ncloud_lb_target_group.alb-tg.target_group_no
  target_no_list = [ncloud_server.tester-server.instance_no]

  depends_on = [
      null_resource.tester-setup
  ]
}