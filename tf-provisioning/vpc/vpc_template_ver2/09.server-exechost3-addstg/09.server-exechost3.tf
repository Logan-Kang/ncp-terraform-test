data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.priv_subnet_cidr
}

data "ncloud_access_control_group" "acg" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}-acg"
}

data "ncloud_init_script" "init-exechost" {
  name    = var.init_script_name
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
  name                  = "tf-${var.account_name}-exechost3-nic"
  subnet_no             = data.ncloud_subnet.vpc_priv_subnet.id
  access_control_groups = [data.ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "exechost3-server" {
  subnet_no                 = data.ncloud_subnet.vpc_priv_subnet.id
  name                      = "tf-${var.account_name}-exechost3-server"
  server_image_product_code = var.server_image_exechost3
  server_product_code       = var.server_spec_exechost3
  network_interface {
    network_interface_no = ncloud_network_interface.exechost3-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = data.ncloud_init_script.init-exechost.id
  depends_on = [
    ncloud_network_interface.exechost3-nic,
    ncloud_login_key.loginkey
  ]
}

resource "ncloud_block_storage" "exechost3-storage" {
    server_instance_no = ncloud_server.exechost3-server.id
    name = "${ncloud_server.exechost3-server.name}-addstg"
    size = var.exechost3_addstg_size
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
resource "null_resource" "exechost-setup" {
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
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost3-nic.private_ip} << EOF",
      "echo 'MOUNTDIR=${var.exechost3_addstg_mountdir}' >> .bash_profile",
      "echo 'export MOUNTDIR' >> .bash_profile",
      "source .bash_profile",
      "EOF",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${ncloud_network_interface.exechost3-nic.private_ip} < add-storage.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
  depends_on = [
      ncloud_server.exechost3-server,
      ncloud_block_storage.exechost3-storage,
      
  ]
}
