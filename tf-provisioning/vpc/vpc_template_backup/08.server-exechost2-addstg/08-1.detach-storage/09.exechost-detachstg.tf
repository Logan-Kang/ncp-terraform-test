data "ncloud_server" "bastion-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-bastion-server"]
  }
}


data "ncloud_network_interface" "exechost2-nic" {
  count = var.num_of_exechost2
  name = "tf-${var.account_name}-exechost2-nic${count.index+1}"
}

## Initial configuration after server creation
resource "null_resource" "exechost2-umount" {
  count = var.num_of_exechost2
  connection {
    type     = "ssh"
    host     = data.ncloud_server.bastion-server.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
    password = var.linux_password
  }

  provisioner "file" {
    source = "./detach-storage.sh"
    destination = "~/detach-storage.sh"
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum install -y sshpass",
      "rm -rf ./password",
      "echo ${var.linux_password} >> ./password",
      "cat ./password",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${data.ncloud_network_interface.exechost2-nic[count.index].private_ip} < detach-storage.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
}
