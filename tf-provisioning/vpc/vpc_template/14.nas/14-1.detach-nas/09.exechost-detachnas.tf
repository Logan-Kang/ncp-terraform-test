data "ncloud_server" "bastion-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-bastion-server"]
  }
}

data "ncloud_server" "exechost-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost-server"]
  }
}

data "ncloud_network_interface" "exechost-nic" {
  filter {
    name = "server_instance_no"
    values = [data.ncloud_server.exechost-server.id]
  }
}

## Initial configuration after server creation
resource "null_resource" "exechost3-umount" {
  connection {
    type     = "ssh"
    host     = data.ncloud_server.bastion-server.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
    password = var.linux_password
  }

  provisioner "file" {
    source = "./detach-nas.sh"
    destination = "~/detach-nas.sh"
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum install -y sshpass",
      "rm -rf ./password",
      "echo ${var.linux_password} >> ./password",
      "cat ./password",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${data.ncloud_network_interface.exechost-nic.private_ip} < detach-nas.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
}
