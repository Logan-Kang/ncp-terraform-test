resource "ncloud_network_interface" "was-nic" {
  name                  = "tf-was-nic"
  subnet_no             = ncloud_subnet.pub_subnet.id
  #private_ip            = "10.0.1.6"
  access_control_groups = [ncloud_access_control_group.acg.id]
}

 ##public server
resource "ncloud_server" "was-server" {
  depends_on = [ null_resource.mysql-setup ]
  subnet_no                 = ncloud_subnet.pub_subnet.id
  name                      = "tf-was-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050"
  network_interface {
    network_interface_no = ncloud_network_interface.was-nic.id
    order = 0
  }
  
  login_key_name = ncloud_login_key.loginkey.key_name
  init_script_no = ncloud_init_script.init-passwd-ubt.id
  
}

resource "ncloud_public_ip" "was-pub-ip" {
  server_instance_no = ncloud_server.was-server.id
}


resource "null_resource" "was-setup" {
  connection {
    type     = "ssh"
    host     = ncloud_public_ip.was-pub-ip.public_ip
    user     = "root"
    port     = "22"
    #password = data.ncloud_root_password.mysql-root-password.root_password
    password = "!Q2w3e4r!"
  }
  provisioner "remote-exec" { // 명령어 실행
    inline = [
      "apt update",
      "apt-get install -y openjdk-8-jdk",
      "export JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-amd64'",
      "apt-get install -y tomcat8",
      "bash -c cat > ~/environment << EOF",
      "PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games'",
      "JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-amd64'",
      "CATALINA_HOME='/usr/share/tomcat8'",
      "CATALINA_BASE='/var/lib/tomcat8'",
      "EOF",
      "cp ~/environment /etc/environment",
      "source /etc/environment",
      "apt install -y software-properties-common",
      "git clone https://github.com/spring-petclinic/spring-framework-petclinic.git",
      "sed  's/localhost:3306/${ncloud_network_interface.mysql-nic.private_ip}:3306/' ./spring-framework-petclinic/pom.xml > ./spring-framework-petclinic/pom1.xml",
      "rm ./spring-framework-petclinic/pom.xml",
      "cp ./spring-framework-petclinic/pom1.xml ./spring-framework-petclinic/pom.xml",
      "sed '1,7d' ./spring-framework-petclinic/src/main/resources/db/mysql/initDB.sql > ./spring-framework-petclinic/src/main/resources/db/mysql/initDB1.sql",
      "rm ./spring-framework-petclinic/src/main/resources/db/mysql/initDB.sql",
      "cp ./spring-framework-petclinic/src/main/resources/db/mysql/initDB1.sql  ./spring-framework-petclinic/src/main/resources/db/mysql/initDB.sql",
      "cd spring-framework-petclinic",
      "./mvnw install -P MySQL -Dmaven.test.skip=true",
      "cp ~/spring-framework-petclinic/target/petclinic.war /var/lib/tomcat8/webapps",
      "sed '94d' /etc/tomcat8/server.xml > ~/server1.xml",
      "sed '95d' ~/server1.xml > ~/server2.xml",
      "rm /etc/tomcat8/server.xml",
      "cp ~/server2.xml /etc/tomcat8/server.xml",
      "service tomcat8 restart",
    ]
  }
  depends_on = [
    ncloud_public_ip.was-pub-ip,
    ncloud_server.was-server
  ]
}