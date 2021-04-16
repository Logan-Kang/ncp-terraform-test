resource "ncloud_init_script" "init-passwd-centos" {
  name    = "tf-chpasswd-centos"
  content = "#!/bin/bash\necho '${var.linux_password}' | passwd --stdin root"
  depends_on = [
    ncloud_vpc.vpc
  ]
}

resource "ncloud_init_script" "init-passwd-ubt" {
  name    = "tf-chpasswd-ubt"
  content = "#!/bin/bash\necho 'root:${var.linux_password}' | chpasswd"
  depends_on = [
    ncloud_vpc.vpc
  ]
}
