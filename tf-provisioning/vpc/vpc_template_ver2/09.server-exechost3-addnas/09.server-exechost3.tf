data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "exechost3_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  filter {
    name = "name"
    values = [var.exechost3_priv_subnet]
  }
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-exechost3" {
  name    = var.init_script_exechost3
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-exechost3-key"
}

data "ncloud_server" "bastion-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-bastion-server"]
  }
}

## make server nic(eth0)
resource "ncloud_network_interface" "exechost3-nic" {
  count = var.num_of_exechost3
  name                  = "tf-${var.account_name}-exechost3-nic${count.index+1}"
  subnet_no             = data.ncloud_subnet.exechost3_priv_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost3-server" {
  count = var.num_of_exechost3
  subnet_no                 = data.ncloud_subnet.exechost3_priv_subnet.id
  name                      = "tf-${var.account_name}-exechost3-server${count.index+1}"
  server_image_product_code = var.server_image_exechost3
  server_product_code       = var.server_spec_exechost3
  network_interface {
    network_interface_no = ncloud_network_interface.exechost3-nic[count.index].id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-exechost3.id
  depends_on = [
    ncloud_network_interface.exechost3-nic,
    ncloud_login_key.loginkey
  ]
}

## make nas
resource "ncloud_nas_volume" "exechost3-nas" {
  volume_name_postfix            = var.exechost3_nas_name_postfix
  volume_size                    = var.exechost3_nas_size
  volume_allotment_protocol_type = var.exechost3_nas_protocol
  
  zone = data.ncloud_subnet.exechost3_priv_subnet.zone
  cifs_user_name = var.exechost3_cifs_user_name
  cifs_user_password = var.exechost3_cifs_user_password
  is_encrypted_volume = var.exechost3_nas_encrypted
  server_instance_no_list = ncloud_server.exechost3-server[*].id

}

## nas mount - exechost edit
resource "null_resource" "exechost3-nfs-setup" {
  count = var.num_of_exechost3
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
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost3-nic[count.index].private_ip} << EOF",
      "echo 'MOUNTDIR=${var.exechost3_nas_mountdir}' >> .bash_profile",
      "echo 'export MOUNTDIR' >> .bash_profile",
      "echo 'NAS_VOL=${ncloud_nas_volume.exechost3-nas.mount_information}' >> .bash_profile",
      "echo 'export NAS_VOL' >> .bash_profile",
      "source .bash_profile",
      "yum install -y nfs-utils",
      "systemctl enable rpcbind",
      "systemctl start rpcbind",
      "EOF",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost3-nic[count.index].private_ip} < mount-nas.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
}
