## make server nic(eth0)
resource "ncloud_network_interface" "tester-nic" {
  name                  = "tf-${var.account_name}-tester-nic"
  subnet_no             = ncloud_subnet.vpc_pub_subnet.id
  access_control_groups = [ncloud_access_control_group.acg.id]
  depends_on = [
    ncloud_login_key.loginkey,
    null_resource.ansible-setup
  ]
}

 ##public server
resource "ncloud_server" "tester-server" {
  subnet_no                 = ncloud_subnet.vpc_pub_subnet.id
  name                      = "tf-${var.account_name}-tester-server"
  server_image_product_code = var.server_image
  network_interface {
    network_interface_no = ncloud_network_interface.tester-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-centos.id
  depends_on = [
    ncloud_network_interface.tester-nic
  ]
}

resource "ncloud_public_ip" "tester-pub-ip" {
  server_instance_no = ncloud_server.tester-server.id
}
## Use when you have not changed your password.
/* 
data "ncloud_root_password" "tester-root-password" {
  server_instance_no = ncloud_server.tester-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}
*/

## Initial configuration after server creation
resource "null_resource" "tester-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.tester-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
    password = var.linux_password
  }
  /*
  # 필요 시 추가
  provisioner "file" {
    source = "./usr.sbin.mysqld"
    destination = "~/usr.sbin.mysqld"
  }
  */
  
  /*
  # 필요 시 추가
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum update -y",
    ]
  }*/
  depends_on = [
      ncloud_public_ip.tester-pub-ip,
      ncloud_server.tester-server,
  ]
}