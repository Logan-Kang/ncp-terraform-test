# classic 서버를 생성합니다.
# 로그인 키를 연동 시, 로그인 키의 관리자 패스워드를 통해 접속이 가능합니다.(ncloud_login_key) - 
# 로그인 키를 연동하지 않으면 가장 최근에 사용한 로그인 키를 등록합니다.
# 현재 구성으로는 사설 IP만 존재하므로, 공인IP를 연결하거나 port forwarding IP를 연동해야 합니다.
resource "ncloud_server" "tf-classic-server" {
  name                      = "tf-${var.site}-server1"
  server_image_product_code = "SPSW0LINUX000139" # centos-7.8-64	
  server_product_code = "SPSVRSTAND000004" # vCPU 2개, 메모리 4GB, 디스크 50GB
  zone = "KR-1"
}

# 생성된 서버에 block storage를 연결합니다.
resource "ncloud_block_storage" "tf-classic-server-addstorage" {
  server_instance_no = ncloud_server.tf-classic-server.instance_no
  name = "${ncloud_server.tf-classic-server.name}-add1"
  size = "10"
  disk_detail_type = "HDD"
  zone = ncloud_server.tf-classic-server.zone
  # 블록스토리지를 스냅샷으로 만들고자 할 경우 해당 옵션을 설정한다. 해당 옵션은 ncloud_block_storage_snapshot 리소스에서 확인한다.
  # snapshot_no = 

}