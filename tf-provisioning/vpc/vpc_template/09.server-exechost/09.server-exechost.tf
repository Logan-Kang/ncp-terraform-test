data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.priv_subnet_cidr
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-exechost-centos" {
  name    = "tf-init-exechost-centos"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-exechost-key"
}

## make server nic(eth0)
resource "ncloud_network_interface" "exechost-nic" {
  name                  = "tf-${var.account_name}-exechost-nic"
  subnet_no             = data.ncloud_subnet.vpc_priv_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost-server" {
  subnet_no                 = data.ncloud_subnet.vpc_priv_subnet.id
  name                      = "tf-${var.account_name}-exechost-server"
  server_image_product_code = var.server_image_exechost
  server_product_code       = var.server_spec_exechost
  network_interface {
    network_interface_no = ncloud_network_interface.exechost-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-exechost-centos.id
  depends_on = [
    ncloud_network_interface.exechost-nic,
    ncloud_login_key.loginkey
  ]
}

/*
resource "ncloud_public_ip" "exechost-pub-ip" {
  server_instance_no = ncloud_server.exechost-server.id
}
*/
## Use when you have not changed your password.
/* 
data "ncloud_root_password" "ansible-root-password" {
  server_instance_no = ncloud_server.ansible-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}
*/

/*
## Initial configuration after server creation
resource "null_resource" "exechost-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.ansible-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
    password = var.linux_password
  }
  
  provisioner "file" {
    source = "../99.file/test"
    destination = "~/test"
  }
  
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "scp test root@${ncloud_network_interface.exechost-nic.private_ip}:/root",
      "ssh root@${ncloud_network_interface.exechost-nic.private_ip}",
      "yum install -y httpd",
      "service httpd enable",
      "service httpd start"
    ]
  }
  depends_on = [
      ncloud_server.exechost-server,
  ]
}
*/