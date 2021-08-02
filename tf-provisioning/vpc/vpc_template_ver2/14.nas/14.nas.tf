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

  provisioner "file" {
    source = "./mount-nas.sh"
    destination = "~/mount-nas.sh"
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum install -y sshpass",
      "rm -rf ./password",
      "echo ${var.linux_password} >> ./password",
      "cat ./password",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${data.ncloud_network_interface.exechost-nic.private_ip} << EOF",
      "echo 'MOUNTDIR=${var.nas_mountdir}' >> .bash_profile",
      "echo 'export MOUNTDIR' >> .bash_profile",
      "echo 'NAS_VOL=${ncloud_nas_volume.exechost-nas.mount_information}' >> .bash_profile",
      "echo 'export NAS_VOL' >> .bash_profile",
      "source .bash_profile",
      "yum install -y nfs-utils",
      "systemctl enable rpcbind",
      "systemctl start rpcbind",
      "EOF",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${data.ncloud_network_interface.exechost-nic.private_ip} < mount-nas.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
}
