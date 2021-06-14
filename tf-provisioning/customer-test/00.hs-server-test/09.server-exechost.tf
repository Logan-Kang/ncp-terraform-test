data "ncloud_vpc" "vpc" {
  name = "test-vpc"
}

data "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = "10.10.40.0/24"
}

data "ncloud_access_control_group" "acg" {
  name = "test-public-svr-acg"
}

data "ncloud_init_script" "init-passwd-centos" {
  name    = "chgpwd-centos"
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-key"
}

## make server nic(eth0)
resource "ncloud_network_interface" "exechost-nic" {
  count = var.num
  name                  = "tf-${var.account_name}-exechost-nic${count.index+1}"
  subnet_no             = data.ncloud_subnet.vpc_pub_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost-server" {
  subnet_no                 = data.ncloud_subnet.vpc_pub_subnet.id
  count = var.num
  name                      = "tf-${var.account_name}-hstest-server${count.index+1}"
  server_image_product_code = var.server_image_exechost
  server_product_code       = var.server_spec_exechost
  network_interface {
    network_interface_no = ncloud_network_interface.exechost-nic[count.index].id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-passwd-centos.id
  depends_on = [
    ncloud_network_interface.exechost-nic,
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_public_ip" "exechost-pub-ip" {
  count = var.num
  server_instance_no = ncloud_server.exechost-server[count.index].id
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