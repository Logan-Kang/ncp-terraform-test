resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-classic-${var.account_name}-key"
}

resource "ncloud_server" "bastion-server" {
  count = var.num
  name  = "tf-${var.account_name}-bastion-vm${count.index+1}"
  server_image_product_code = var.server_image_bastion
  server_product_code = var.server_spec_bastion
  zone = var.zone

  login_key_name = ncloud_login_key.loginkey.key_name
  depends_on = [
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_public_ip" "bastion-pub-ip" {
  count = var.num
  server_instance_no = ncloud_server.bastion-server[count.index].id
}
## Use when you have not changed your password.

data "ncloud_root_password" "bastion-root-password" {
  count = var.num
  server_instance_no = ncloud_server.bastion-server[count.index].id
  private_key        = ncloud_login_key.loginkey.private_key
}

## Initial configuration after server creation
resource "null_resource" "bastion-setup" {
  count = var.num
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.bastion-pub-ip[count.index].public_ip
    user     = "root"
    port     = "22"
    password = data.ncloud_root_password.bastion-root-password[count.index].root_password
    #password = var.linux_password
  }
  /*
  provisioner "file" {
    source = "./usr.sbin.mysqld"
    destination = "~/usr.sbin.mysqld"
  }
  */
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "echo '${var.linux_password}' | passwd --stdin root",
    ]
  }
  depends_on = [
      ncloud_public_ip.bastion-pub-ip,
      ncloud_server.bastion-server,
  ]
}