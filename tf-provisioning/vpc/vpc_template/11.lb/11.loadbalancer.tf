data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}


data "ncloud_subnet" "vpc_lb_subnet1" {
  vpc_no = data.ncloud_vpc.vpc.id
  filter {
    name   = "name"
    values = ["${data.ncloud_vpc.vpc.name}-lb-subnet1"]
  }
}

data "ncloud_subnet" "vpc_lb_subnet2" {
  vpc_no = data.ncloud_vpc.vpc.id
  filter {
    name   = "name"
    values = ["${data.ncloud_vpc.vpc.name}-lb-subnet2"]
  }
}

data "ncloud_lb_target_group" "lb-tg-exechost1" {
  filter {
    name   = "name"
    values = ["${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost1-tg"]
  }
}
data "ncloud_lb_target_group" "lb-tg-exechost2" {
  filter {
    name   = "name"
    values = ["${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost2-tg"]
  }
}
data "ncloud_lb_target_group" "lb-tg-exechost3" {
  filter {
    name   = "name"
    values = ["${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost3-tg"]
  }
}

resource "ncloud_lb" "loadbalancer" {
  name         = "${data.ncloud_vpc.vpc.name}-${var.lb_name}"
  network_type = var.lb_network_type
  type         = var.lb_type
  subnet_no_list = var.lb_type == "NETWORK" ? [data.ncloud_subnet.vpc_lb_subnet1.subnet_no] : [data.ncloud_subnet.vpc_lb_subnet1.subnet_no,data.ncloud_subnet.vpc_lb_subnet2.subnet_no]
}

resource "ncloud_lb_listener" "lb-listener-exechost1" {
  count            = var.num_of_exechost1 >= 1 ? 1 : 0
  load_balancer_no = ncloud_lb.loadbalancer.load_balancer_no
  protocol         = var.listener_protocol_exechost1
  port             = var.listener_port_exechost1
  target_group_no  = data.ncloud_lb_target_group.lb-tg-exechost1.target_group_no
}

resource "ncloud_lb_listener" "lb-listener-exechost2" {
  count            = var.num_of_exechost2 >= 1 ? 1 : 0
  load_balancer_no = ncloud_lb.loadbalancer.load_balancer_no
  protocol         = var.listener_protocol_exechost2
  port             = var.listener_port_exechost2
  target_group_no  = data.ncloud_lb_target_group.lb-tg-exechost2.target_group_no
}

resource "ncloud_lb_listener" "lb-listener-exechost3" {
  count            = var.num_of_exechost3 >= 1 ? 1 : 0
  load_balancer_no = ncloud_lb.loadbalancer.load_balancer_no
  protocol         = var.listener_protocol_exechost3
  port             = var.listener_port_exechost3
  target_group_no  = data.ncloud_lb_target_group.lb-tg-exechost3.target_group_no
}
