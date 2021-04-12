
resource "ncloud_server" "tf-web-kr1" {
  name                      = "tf-${var.employNum}-web"
  server_image_product_code = "SPSW0LINUX000139" # centos-7.8-64	
  server_product_code = "SPSVRSTAND000004" # vCPU 2개, 메모리 4GB, 디스크 50GB
  zone = "KR-1"

  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-centos.id
}