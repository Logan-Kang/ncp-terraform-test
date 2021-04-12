# classic 서버를 생성합니다.
# 로그인 키를 연동 시, 로그인 키의 관리자 패스워드를 통해 접속이 가능합니다.(ncloud_login_key) - 
# 로그인 키를 연동하지 않으면 가장 최근에 사용한 로그인 키를 등록합니다.
# 현재 구성으로는 사설 IP만 존재하므로, 공인IP를 연결하거나 port forwarding IP를 연동해야 합니다.

resource "ncloud_server" "tf-classic-server" {
  count = var.num
  name                      = "tf-${var.account_name}-${format("%.3s",var.site)}-classic-server"
  server_image_product_code = var.imagecode
  server_product_code = var.speccode
  zone = var.zone
}