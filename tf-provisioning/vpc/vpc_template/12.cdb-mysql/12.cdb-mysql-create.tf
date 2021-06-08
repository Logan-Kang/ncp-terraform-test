data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.pub_subnet_cidr
}

resource "null_resource" "cdb-mysql-create" {
    provisioner "local-exec" {
        working_dir = var.path_module
        
        command = <<EOF
${var.path_module}/cdb_mysql.sh GET '/vmysql/v2/createCloudMysqlInstance?vpcNo=${data.ncloud_vpc.vpc.id}&cloudMysqlServiceName=${var.cdbmysql_name}&cloudMysqlServerNamePrefix=${var.cdbmysql_prefix}&cloudMysqlUserName=${var.cdbmysql_username}&cloudMysqlUserPassword=${var.cdbmysql_userpwd}&hostIp=${var.cdbmysql_hostIP}&cloudMysqlDatabaseName=${var.cdbmysql_dbname}&subnetNo=${data.ncloud_subnet.vpc_pub_subnet.id}&responseFormatType=json'
        EOF
    }
}