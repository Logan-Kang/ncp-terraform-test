# 로그인 키를 생성합니다.
# 이 로그인 키에 관리자 패스워드가 포함되어 있으며 생성한 키에 대한 공개키, 비밀키는 terraform.tfstate에서 확인할 수 있습니다.
# 이를 통해 관리자 패스워드를 확인하고자 할 경우 data "ncloud_root_password"를 활용합니다. -> 관리자 패스워드를 terraform.tfstate에서 확인할 수 있습니다.
resource "ncloud_login_key" "loginkey" {
  key_name = "tftest"
}

# classic 서버를 생성합니다.
# 로그인 키를 연동하였으며, 이 로그인 키의 관리자 패스워드를 통해 접속이 가능합니다.
resource "ncloud_server" "tf-classic-server" {
  name                      = "tf-${var.site}-classic-server"
  server_image_product_code = "SPSW0LINUX000139" # centos-7.8-64	
  server_product_code = "SPSVRSTAND000004" # vCPU 2개, 메모리 4GB, 디스크 50GB
  zone = "KR-1"
  login_key_name = ncloud_login_key.loginkey.key_name
}

