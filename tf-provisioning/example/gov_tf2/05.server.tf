resource "ncloud_login_key" "loginkey" {
  key_name = "tftest"
}

 ##public server
resource "ncloud_server" "gov-server" {
  name                      = "tf-gov-server"
  server_image_product_code = "SPSW0LINUX000139"
  server_product_code = "SPSVRSTAND000024"
  zone = "KR-1"
  login_key_name = ncloud_login_key.loginkey.key_name
  
}

resource "ncloud_public_ip" "gov-pub-ip" {
  server_instance_no = ncloud_server.gov-server.id
}
