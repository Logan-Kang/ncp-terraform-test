data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "exechost2_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  filter {
    name = "name"
    values = [var.exechost2_priv_subnet]
  }
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-exechost2" {
  name    = var.init_script_exechost2
}

resource "ncloud_login_key" "loginkey" {
  key_name = "Terraform-${var.account_name}-exechost2-key"
}

data "ncloud_server" "bastion-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-bastion-server"]
  }
}

## make server nic(eth0)
resource "ncloud_network_interface" "exechost2-nic" {
  count = var.num_of_exechost2
  name                  = "tf-${var.account_name}-exechost2-nic${count.index+1}"
  subnet_no             = data.ncloud_subnet.exechost2_priv_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost2-server" {
  count = var.num_of_exechost2
  subnet_no                 = data.ncloud_subnet.exechost2_priv_subnet.id
  name                      = "tf-${var.account_name}-exechost2-server${count.index+1}"
  server_image_product_code = var.server_image_exechost2
  server_product_code       = var.server_spec_exechost2
  network_interface {
    network_interface_no = ncloud_network_interface.exechost2-nic[count.index].id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-exechost2.id
  depends_on = [
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_block_storage" "exechost2-addstorage" {
    count = var.num_of_exechost2
    server_instance_no = ncloud_server.exechost2-server[count.index].id
    name = "${ncloud_server.exechost2-server[count.index].name}-add${count.index+1}"
    size = var.exechost2_addstg_size
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


## Initial configuration after server creation
resource "null_resource" "exechost2-setup" {
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
    source = "./add-storage.sh"
    destination = "~/add-storage.sh"
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum install -y sshpass",
      "rm -rf ./password",
      "echo ${var.linux_password} >> ./password",
      "cat ./password",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost2-nic[count.index].private_ip} << EOF",
      "echo 'MOUNTDIR=${var.exechost2_addstg_mountdir}' >> .bash_profile",
      "echo 'export MOUNTDIR' >> .bash_profile",
      "source .bash_profile",
      "EOF",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost2-nic[count.index].private_ip} < add-storage.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
  depends_on = [
      ncloud_block_storage.exechost2-addstorage,
      
  ]
}
