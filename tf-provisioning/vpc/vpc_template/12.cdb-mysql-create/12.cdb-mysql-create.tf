data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_priv_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.priv_subnet_cidr
}

resource "null_resource" "cdb-mysql-create" {
    provisioner "local-exec" {
        working_dir = var.path_module
        
        command = <<EOF
${var.path_module}/cdb_mysql.sh GET "/vmysql/v2/createCloudMysqlInstance?vpcNo=${data.ncloud_vpc.vpc.id}&cloudMysqlImageProductCode=${var.cdbmysql_imagecode}&cloudMysqlProductCode=${var.cdbmysql_prdcode}&isHa=${var.cdbmysql_isHa}&isMultiZone=${var.cdbmysql_isMultiZone}&cloudMysqlServiceName=${var.cdbmysql_name}&cloudMysqlServerNamePrefix=${var.cdbmysql_prefix}&cloudMysqlUserName=${var.cdbmysql_username}&cloudMysqlUserPassword=${var.cdbmysql_userpwd}&hostIp=${var.cdbmysql_hostIP}&cloudMysqlPort=${var.cdbmysql_port}&cloudMysqlDatabaseName=${var.cdbmysql_dbname}&subnetNo=${data.ncloud_subnet.vpc_priv_subnet.id}&responseFormatType=json" >> ${var.path_module}/output.apistate

        EOF
    }
}