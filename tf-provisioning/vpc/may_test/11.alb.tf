resource "ncloud_lb" "applicationLB" {
  name = "${ncloud_vpc.vpc.name}-alb"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ ncloud_subnet.vpc_lb_subnet.subnet_no ]
  depends_on = [
      ncloud_lb_target_group.alb-tg
  ]
}

resource "ncloud_lb_listener" "alb-listener" {
  load_balancer_no = ncloud_lb.applicationLB.load_balancer_no
  protocol = "HTTP"
  port = 80
  target_group_no = ncloud_lb_target_group.alb-tg.target_group_no

  depends_on = [
      ncloud_lb_target_group.alb-tg
  ]
}