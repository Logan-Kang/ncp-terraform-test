resource "ncloud_login_key" "tf-loginkey" {
  key_name = "tf-${var.employNum}-key"
}
