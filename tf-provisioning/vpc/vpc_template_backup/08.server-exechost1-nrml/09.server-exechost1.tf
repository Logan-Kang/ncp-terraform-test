data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "exechost1_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  filter {
    name = "name"
    values = [var.exechost1_priv_subnet]
  }
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-exechost1" {
  name    = var.init_script_exechost1
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-exechost1-key"
}

## make server nic(eth0)
resource "ncloud_network_interface" "exechost1-nic" {
  count = var.num_of_exechost1
  name                  = "tf-${var.account_name}-exechost1-nic${count.index+1}"
  subnet_no             = data.ncloud_subnet.exechost1_priv_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost1-server" {
  subnet_no                 = data.ncloud_subnet.exechost1_priv_subnet.id
  count = var.num_of_exechost1
  name                      = "tf-${var.account_name}-exechost1-server${count.index+1}"
  server_image_product_code = var.server_image_exechost1
  server_product_code       = var.server_spec_exechost1
  network_interface {
    network_interface_no = ncloud_network_interface.exechost1-nic[count.index].id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-exechost1.id
  depends_on = [
    ncloud_network_interface.exechost1-nic,
    ncloud_login_key.loginkey
  ]
}
