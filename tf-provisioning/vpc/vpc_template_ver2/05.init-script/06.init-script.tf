resource "ncloud_init_script" "init-passwd-centos" {
  name    = "tf-chpasswd-centos"
  content = "#!/bin/bash\necho '${var.linux_password}' | passwd --stdin root"
}

resource "ncloud_init_script" "init-passwd-ubt" {
  name    = "tf-chpasswd-ubt"
  content = "#!/bin/bash\necho 'root:${var.linux_password}' | chpasswd"
}

resource "ncloud_init_script" "init-bastion-centos" {
  name    = "tf-init-bastion-centos"
  content = "#!/bin/bash\necho '${var.linux_password}' | passwd --stdin root\nifconfig eth0 mtu 1500"
}

resource "ncloud_init_script" "init-bastion-ubt" {
  name    = "tf-init-bastion-ubt"
  content = "#!/bin/bash\necho 'root:${var.linux_password}' | chpasswd\nifconfig eth0 mtu 1500"
}

resource "ncloud_init_script" "init-exechost-centos" {
  name    = "tf-init-exechost-centos"
  content = "#!/bin/bash\necho '${var.linux_password}' | passwd --stdin root\nyum install -y epel-release && yum install -y nginx\nsystemctl enable nginx && systemctl start nginx"
}

resource "ncloud_init_script" "init-exechost-ubt" {
  name    = "tf-init-exechost-ubt"
  content = "#!/bin/bash\necho 'root:${var.linux_password}' | chpasswd\napt-get install -y nginx\nsystemctl enable nginx && systemctl start nginx"
}