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

## make nas
resource "ncloud_nas_volume" "exechost-nas" {
  volume_name_postfix            = var.nas_name_postfix
  volume_size                    = var.nas_size
  volume_allotment_protocol_type = var.nas_protocol
  
  zone = var.zone
  cifs_user_name = var.cifs_user_name
  cifs_user_password = var.cifs_user_password
  is_encrypted_volume = var.nas_encrypted
  server_instance_no_list = [data.ncloud_server.exechost-server.id]

}

## nas mount - exechost edit
resource "null_resource" "exechost-nfs-setup" {
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
      "ssh root@${data.ncloud_network_interface.exechost-nic.private_ip}",
      "yum install -y nfs-utils",
      "systemctl enable rpcbind",
      "mkdir /mnt/nas",
      "mount -t nfs ${ncloud_nas_volume.exechost-nas.custom_ip_list}:/${ncloud_nas_volume.exechost-nas.name} /mnt/nas",
      "mkdir /mnt/backup",
      "cp /etc/fstab /mnt/backup/fstab-backup",
      "echo '${ncloud_nas_volume.exechost-nas.custom_ip_list}:/${ncloud_nas_volume.exechost-nas.name} /mnt/nas nfs defaults 0 0' >> /etc/fstab",
    ]
  }
  depends_on = [
      ncloud_nas_volume.exechost-nas,
  ]

}
