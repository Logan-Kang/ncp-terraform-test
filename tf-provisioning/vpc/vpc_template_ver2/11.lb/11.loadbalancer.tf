data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}
data "ncloud_subnet" "vpc_lb_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.lb_subnet_cidr
}
data "ncloud_lb_target_group" "lb-tg" {
  filter {
    name = "name"
    values = ["${data.ncloud_vpc.vpc.name}-${var.lb_name}-tg"]
  }
}

resource "ncloud_lb" "loadbalancer" {
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}"
  network_type = var.lb_network_type
  type = var.lb_type
  subnet_no_list = [ data.ncloud_subnet.vpc_lb_subnet.subnet_no ]
}

resource "ncloud_lb_listener" "lb-listener" {
  load_balancer_no = ncloud_lb.loadbalancer.load_balancer_no
  protocol = var.listener_protocol
  port = var.listener_port
  target_group_no = data.ncloud_lb_target_group.lb-tg.target_group_no

}