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

## nas umount - exechost edit
resource "null_resource" "exechost-nfs-umount" {
  connection {
    type     = "ssh"
    host     = data.ncloud_server.bastion-server.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.ansible-root-password.root_password
    password = var.linux_password
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "ssh root@${data.ncloud_server.exechost-server.private_ip}",
      "rm -rf /etc/fstab",
      "mv /mnt/backup/fstab-backup /etc/fstab"
      "umount /mnt/nas",
      "echo '${ncloud_nas_volume.exechost-nas.custom_ip_list}:/${ncloud_nas_volume.exechost-nas.name} /mnt/nas nfs defaults 0 0' >> /etc/fstab",
    ]
  }

}
