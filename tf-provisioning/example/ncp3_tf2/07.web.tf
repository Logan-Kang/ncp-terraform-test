resource "ncloud_network_interface" "web-nic" {
  name                  = "tf-web-nic"
  subnet_no             = ncloud_subnet.pub_subnet.id
  #private_ip            = "10.0.1.6"
  access_control_groups = [ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "web-server" {
  depends_on = [ null_resource.was-setup ]
  subnet_no                 = ncloud_subnet.pub_subnet.id
  name                      = "tf-web-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050"
  network_interface {
    network_interface_no = ncloud_network_interface.web-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-ubt.id
  
}

resource "ncloud_public_ip" "web-pub-ip" {
  server_instance_no = ncloud_server.web-server.id
}


resource "null_resource" "web-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.web-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.mysql-root-password.root_password
    password = "!Q2w3e4r!"
  }
  provisioner "file" {
    source = "./000-default.conf"
    destination = "~/000-default.conf"
  }
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "apt update",
      "apt-get install -y apache2",
      "apt-get install -y libapache2-mod-jk",
      "bash -c cat > ~/workers.properties << EOF",
      "workers.tomcat_home=/usr/share/tomcat8",
      "workers.java_home=/usr/lib/jvm/java-default",
      "worker.list=tomcat1",
      "worker.tomcat1.port = 8009",
      "worker.tomcat1.host = ${ncloud_network_interface.was-nic.private_ip}",
      "worker.tomcat1.type = ajp13",
      "worker.tomcat1.lbfactor = 20",
      "EOF",
      "cp ~/workers.properties /etc/apache2/workers.properties",    
      "sed '23d' /etc/apache2/mods-available/jk.conf > ~/jk1.conf",
      "sed '23a JkWorkersFile /etc/apache2/workers.properties' ~/jk1.conf > ~/jk2.conf",
      "rm /etc/apache2/mods-available/jk.conf",
      "cp ~/jk2.conf /etc/apache2/mods-available/jk.conf",
      "rm /etc/apache2/sites-available/000-default.conf",
      "cp ~/000-default.conf /etc/apache2/sites-available/000-default.conf",
      "ln -s /etc/apache2/mods-available/headers.load /etc/apache2/mods-enabled/mods-headers.load",
      "service apache2 restart",
      "apt install -y software-properties-common",
    ]
  }
  depends_on = [
    ncloud_public_ip.web-pub-ip,
    ncloud_server.web-server
  ]
}