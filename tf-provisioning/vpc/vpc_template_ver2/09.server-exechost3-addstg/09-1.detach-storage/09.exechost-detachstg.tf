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

data "ncloud_server" "bastion-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-bastion-server"]
  }
}

data "ncloud_server" "exechost3-server" {
  filter {
    name = "name"
    values = ["tf-${var.account_name}-exechost3-server"]
  }
}


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
    source = "./detach-storage.sh"
    destination = "~/detach-storage.sh"
  }

  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "yum install -y sshpass",
      "rm -rf ./password",
      "echo ${var.linux_password} >> ./password",
      "cat ./password",
      "sshpass -f ./password ssh -o StrictHostKeyChecking=no root@${data.ncloud_server.exechost3-server.private_ip} < detach-storage.sh",
      "echo '=== REMOTE-EXEC END==='",
    ]
  }
}
