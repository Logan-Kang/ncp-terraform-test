resource "ncloud_login_key" "loginkey" {
  key_name = "tf-key"
}

resource "ncloud_network_interface" "mysql-nic" {
  name                  = "tf-mysql-nic"
  subnet_no             = ncloud_subnet.pub_subnet.id
  #private_ip            = "10.0.1.6"
  access_control_groups = [ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "mysql-server" {
  subnet_no                 = ncloud_subnet.pub_subnet.id
  name                      = "tf-mysql-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050"
  network_interface {
    network_interface_no = ncloud_network_interface.mysql-nic.id
    order = 0
  }
  ##(server image list)
  ##"SW.VSVR.APP.LNX64.CNTOS.0703.PINPT.173.B050" = "Pinpoint(1.7.3)-centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0703.B050" = "centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0708.B050" = "CentOS 7.8 (64-bit)"
  ##"SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050" = "ubuntu-16.04-64-server"
  ##"SW.VSVR.OS.WND64.WND.SVR2016EN.B100" = "Windows Server 2016 (64-bit) English Edition"
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-ubt.id
  
}

resource "ncloud_public_ip" "mysql-pub-ip" {
  server_instance_no = ncloud_server.mysql-server.id
}

data "ncloud_root_password" "mysql-root-password" {
  server_instance_no = ncloud_server.mysql-server.id
  private_key        = ncloud_login_key.loginkey.private_key
}

/*resource "ncloud_block_storage" "mysql-addstorage" {
    server_instance_no = ncloud_server.mysql-server.id
    name = "tf-mysql-addstg1"
    size = "100"
    disk_detail_type = "HDD"
}*/

resource "null_resource" "mysql-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.mysql-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.mysql-root-password.root_password
    password = "!Q2w3e4r!"
  }
  provisioner "file" {
    source = "./usr.sbin.mysqld"
    destination = "~/usr.sbin.mysqld"
  }
  provisioner "file" {
    source = "./alias"
    destination = "~/alias"
  }
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "apt update",
      "apt-get install -y debconf-utils",
      /*"echo -e 'o\nn\np\n1\n\n\nw' | fdisk /dev/xvdb",
      "mkfs.ext4 /dev/xvdb1",
      "uuid=$(blkid | grep xvdb1 | cut -d '=' -f 2 | cut -d ' ' -f 1 | cut -c 2- | cut -c -36)",
      "echo UUID=$uuid /data ext4 defaults 0 0 > ~/uuid",
      "chmod 666 /etc/fstab",
      "cat ~/uuid >> /etc/fstab",
      "chmod 644 /etc/fstab",*/
      "mkdir /data",
      #"mount -a",
      "bash -c cat > ~/test.sql << EOF",
      "GRANT ALL PRIVILEGES ON *.* to 'root'@'%' IDENTIFIED BY 'petclinic';",
      "CREATE DATABASE petclinic;",
      "flush privileges;",
      "EOF",
      "echo 'mysql-server-5.7 mysql-server/root_password password petclinic' | debconf-set-selections",
      "echo 'mysql-server-5.7 mysql-server/root_password_again password petclinic' | debconf-set-selections",
      "apt-get install -y mysql-server-5.7",

      "mysql -u root -ppetclinic < ~/test.sql",
      "service mysql restart",
      "bash -c cat > ~/mysqld.cnf << EOF",
      "[mysqld_safe]",
      "socket          = /var/run/mysqld/mysqld.sock",
      "nice            = 0",
      "[mysqld]",
      "user            = mysql",
      "pid-file        = /var/run/mysqld/mysqld.pid",
      "socket          = /var/run/mysqld/mysqld.sock",
      "port            = 3306",
      "basedir         = /usr",
      "datadir         = /data/mysql",
      "tmpdir          = /tmp",
      "lc-messages-dir = /usr/share/mysql",
      "skip-external-locking",
      "key_buffer_size         = 16M",
      "max_allowed_packet      = 16M",
      "thread_stack            = 192K",
      "thread_cache_size       = 8",
      "myisam-recover-options  = BACKUP",
      "query_cache_limit       = 1M",
      "query_cache_size        = 16M",
      "log_error = /var/log/mysql/error.log",
      "expire_logs_days        = 10",
      "max_binlog_size   = 100M",
      "EOF",
      "service mysql stop",
      "rm /etc/mysql/mysql.conf.d/mysqld.cnf",
      "cp ~/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf",
      "rm /etc/apparmor.d/usr.sbin.mysqld",
      "cp ~/usr.sbin.mysqld /etc/apparmor.d/usr.sbin.mysqld",
      "chmod 644 /etc/apparmor.d/usr.sbin.mysqld",
      "rm /etc/apparmor.d/tunables/alias",
      "cp ~/alias /etc/apparmor.d/tunables/alias",
      "chmod 644 /etc/apparmor.d/tunables/alias",
      "rsync -av /var/lib/mysql /data/",
      "chown -R mysql:mysql /data/mysql",
      "service mysql start",
      "systemctl restart apparmor",
      "service mysql restart",
    ]
  }
  depends_on = [
    ncloud_public_ip.mysql-pub-ip,
    ncloud_server.mysql-server,
    #ncloud_block_storage.mysql-addstorage
  ]
}


/*

resource "ncloud_network_interface" "priv-server-nic" {
  name                  = "tf-priv-server-nic"
  subnet_no             = ncloud_subnet.priv_subnet.id
  #private_ip            = "10.0.1.6"
  access_control_groups = [ncloud_access_control_group.acg.id]
}
resource "ncloud_server" "mysql" {
  #depends_on = [ ncloud_route.add-natgw ]
  subnet_no                 = ncloud_subnet.priv_subnet.id
  name                      = "tf-mysql-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050"
  network_interface {
    network_interface_no = ncloud_network_interface.priv-server-nic.id
    order = 0
  }

  login_key_name = "testkey"
#  init_script_no = ncloud_init_script.init-passwd.id
}*/

