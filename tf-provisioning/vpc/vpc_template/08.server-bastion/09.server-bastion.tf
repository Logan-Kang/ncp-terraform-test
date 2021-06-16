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

data "ncloud_init_script" "init-bastion-centos" {
  name    = "tf-init-bastion-centos"
}

data "ncloud_init_script" "init-passwd-ubt" {
  name    = "tf-chpasswd-ubt"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-key"
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
  init_script_no = data.ncloud_init_script.init-bastion-centos.id
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
resource "null_resource" "bastion-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.bastion-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.bastion-root-password.root_password
    password = var.linux_password
  }
  /*
  provisioner "file" {
    source = "./usr.sbin.mysqld"
    destination = "~/usr.sbin.mysqld"
  }
  */
  /*provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum update -y",
    ]
  }*/
  depends_on = [
      ncloud_public_ip.bastion-pub-ip,
      ncloud_server.bastion-server,
  ]
}