data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.pub_subnet_cidr
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-bastion" {
  name    = var.init_script_bastion
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-bastion-key"
}

## make server nic(eth0)
resource "ncloud_network_interface" "bastion-nic" {
  name                  = "tf-${var.account_name}-bastion-nic"
  subnet_no             = data.ncloud_subnet.vpc_pub_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "bastion-server" {
  subnet_no                 = data.ncloud_subnet.vpc_pub_subnet.id
  name                      = "tf-${var.account_name}-bastion-server"
  server_image_product_code = var.server_image_bastion
  server_product_code       = var.server_spec_bastion
  network_interface {
    network_interface_no = ncloud_network_interface.bastion-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-bastion.id


  depends_on = [
    ncloud_network_interface.bastion-nic,
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_public_ip" "bastion-pub-ip" {
  server_instance_no = ncloud_server.bastion-server.id
}
## Use when you have not changed your password.
/* 
data "ncloud_root_password" "bastion-root-password" {
  server_instance_no = ncloud_server.bastion-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}
*/

## Initial configuration after server creation
