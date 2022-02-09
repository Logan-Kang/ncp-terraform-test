data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_server" "exechost1-server" {
  count = var.num_of_exechost1
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost1-server${count.index+1}"]
  }
}
data "ncloud_server" "exechost2-server" {
  count = var.num_of_exechost2
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost2-server${count.index+1}"]
  }
}

data "ncloud_server" "exechost3-server" {
  count = var.num_of_exechost3
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost3-server${count.index+1}"]
  }
}

## exechost1 target group
resource "ncloud_lb_target_group" "lb-tg-exechost1" {
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost1-tg"
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

## exechost2 target group
resource "ncloud_lb_target_group" "lb-tg-exechost2" {
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost2-tg"
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

## exechost3 target group
resource "ncloud_lb_target_group" "lb-tg-exechost3" {
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost3-tg"
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

resource "ncloud_lb_target_group_attachment" "lb-tg-attach-exechost1" {
  target_group_no = ncloud_lb_target_group.lb-tg-exechost1.target_group_no
  target_no_list = data.ncloud_server.exechost1-server[*].instance_no
}

resource "ncloud_lb_target_group_attachment" "lb-tg-attach-exechost2" {
  count = var.num_of_exechost2 >= 1 ? 1 : 0
  target_group_no = ncloud_lb_target_group.lb-tg-exechost2.target_group_no
  target_no_list = data.ncloud_server.exechost2-server[*].instance_no
}

resource "ncloud_lb_target_group_attachment" "lb-tg-attach-exechost3" {
  count = var.num_of_exechost3 >= 1 ? 1 : 0
  target_group_no = ncloud_lb_target_group.lb-tg-exechost3.target_group_no
  target_no_list = data.ncloud_server.exechost3-server[*].instance_no
}


/*
## make target group for application loadbalancer
resource "ncloud_lb_target_group" "lb-tg-exechost1" {
  count = var.num_of_exechost1 >= 1 ? 1 : 0
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost1-tg"
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

resource "ncloud_lb_target_group_attachment" "lb-tg-attach-exechost1" {
  count = var.num_of_exechost1 >= 1 ? 1 : 0
  target_group_no = ncloud_lb_target_group.lb-tg-exechost1[count.index].target_group_no
  target_no_list = data.ncloud_server.exechost1-server[*].instance_no
}
/*
resource "ncloud_lb_target_group" "lb-tg-exechost2" {
  count = var.num_of_exechost2 >= 1 ? 1 : 0
  vpc_no   = data.ncloud_vpc.vpc.id
  name = "${data.ncloud_vpc.vpc.name}-${var.lb_name}-exechost2-tg"
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
resource "ncloud_lb_target_group_attachment" "lb-tg-attach-exechost2" {
  count = var.num_of_exechost2 >= 1 ? 1 : 0
  target_group_no = ncloud_lb_target_group.lb-tg-exechost2.target_group_no
  target_no_list = [data.ncloud_server.exechost1-server[*].instance_no]
}
*/