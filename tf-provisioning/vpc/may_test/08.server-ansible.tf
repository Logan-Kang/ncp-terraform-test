resource "ncloud_network_interface" "ansible-nic" {
  name                  = "tf-${var.account_name}-ansible-nic"
  subnet_no             = ncloud_subnet.vpc_pub_subnet.id
  access_control_groups = [ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "ansible-server" {
  subnet_no                 = ncloud_subnet.vpc_pub_subnet.id
  name                      = "tf-${var.account_name}-ansible-server"
  server_image_product_code = var.server_image
  network_interface {
    network_interface_no = ncloud_network_interface.ansible-nic.id
    order = 0
  }
  
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-centos.id
}

resource "ncloud_public_ip" "ansible-pub-ip" {
  server_instance_no = ncloud_server.ansible-server.id
}

data "ncloud_root_password" "ansible-root-password" {
  server_instance_no = ncloud_server.ansible-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}

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
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum update -y",
    ]
  }
  depends_on = [
      ncloud_public_ip.ansible-pub-ip,
      ncloud_server.ansible-server,
  ]
}