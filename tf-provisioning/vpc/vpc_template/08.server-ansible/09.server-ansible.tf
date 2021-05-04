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

data "ncloud_init_script" "init-passwd-centos" {
  name    = "tf-chpasswd-centos"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-key"
}

## make server nic(eth0)
resource "ncloud_network_interface" "ansible-nic" {
  name                  = "tf-${var.account_name}-ansible-nic"
  subnet_no             = data.ncloud_subnet.vpc_pub_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "ansible-server" {
  subnet_no                 = data.ncloud_subnet.vpc_pub_subnet.id
  name                      = "tf-${var.account_name}-ansible-server"
  server_image_product_code = var.server_image
  server_product_code       = var.server_spec
  network_interface {
    network_interface_no = ncloud_network_interface.ansible-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-passwd-centos.id
  depends_on = [
    ncloud_network_interface.ansible-nic,
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_public_ip" "ansible-pub-ip" {
  server_instance_no = ncloud_server.ansible-server.id
}
## Use when you have not changed your password.
/* 
data "ncloud_root_password" "ansible-root-password" {
  server_instance_no = ncloud_server.ansible-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}
*/

## Initial configuration after server creation
resource "null_resource" "ansible-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.ansible-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
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
      ncloud_public_ip.ansible-pub-ip,
      ncloud_server.ansible-server,
  ]
}