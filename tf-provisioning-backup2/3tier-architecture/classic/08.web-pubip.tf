resource "ncloud_public_ip" "web-pub-ip" {
  server_instance_no = ncloud_server.tf-web-kr1.id
}