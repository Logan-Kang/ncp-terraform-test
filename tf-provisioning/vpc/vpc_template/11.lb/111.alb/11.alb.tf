data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}
data "ncloud_subnet" "vpc_lb_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.lb_subnet_cidr
}
data "ncloud_lb_target_group" "alb-tg" {
  filter {
    name = "name"
    values = ["${data.ncloud_vpc.vpc.name}-alb-tg"]
  }
}

resource "ncloud_lb" "applicationLB" {
  name = "${data.ncloud_vpc.vpc.name}-alb"
  network_type = "PUBLIC"
  type = "APPLICATION"
  subnet_no_list = [ data.ncloud_subnet.vpc_lb_subnet.subnet_no ]
}

resource "ncloud_lb_listener" "alb-listener" {
  load_balancer_no = ncloud_lb.applicationLB.load_balancer_no
  protocol = "HTTP"
  port = 80
  target_group_no = data.ncloud_lb_target_group.alb-tg.target_group_no

}