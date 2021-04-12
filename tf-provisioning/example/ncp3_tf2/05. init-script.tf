resource "ncloud_init_script" "init-passwd-centos" {
  name    = "tf-chpasswd-centos"
  content = "#!/bin/bash\necho '!Q2w3e4r!' | passwd --stdin root"
}

resource "ncloud_init_script" "init-passwd-ubt" {
  name    = "tf-chpasswd-ubt"
  content = "#!/bin/bash\necho 'root:!Q2w3e4r!' | chpasswd"
}
