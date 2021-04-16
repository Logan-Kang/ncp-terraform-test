# classic 서버를 생성합니다.
# 로그인 키를 연동 시, 로그인 키의 관리자 패스워드를 통해 접속이 가능합니다.(ncloud_login_key) - 
# 로그인 키를 연동하지 않으면 가장 최근에 사용한 로그인 키를 등록합니다.
resource "ncloud_server" "tf-classic-server" {
  name                      = "tf-${var.site}-classic-server"
  server_image_product_code = "SPSW0LINUX000139" # centos-7.8-64	
  server_product_code = "SPSVRSTAND000004" # vCPU 2개, 메모리 4GB, 디스크 50GB
  zone = "KR-1"
}

# 공인 ip를 생성하여 위에 생성한 서버에 연동합니다.
resource "ncloud_public_ip" "gov-pub-ip" {
  server_instance_no = ncloud_server.tf-pub-classic-server.id
}
