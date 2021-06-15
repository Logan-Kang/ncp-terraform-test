data "ncloud_vpc" "vpc" {
  name = "tf-${var.account_name}-vpc${var.vpc_num}"
}

data "ncloud_subnet" "vpc_pub_subnet" {
  vpc_no = data.ncloud_vpc.vpc.id
  subnet = var.pub_subnet_cidr
}


resource "null_resource" "cdb-mysql-delete" {
    provisioner "local-exec" {
        working_dir = var.path_module
        
        command = <<EOF
CDB_NUM=$(${var.path_module}/cdb_mysql.sh GET "/vmysql/v2/getCloudMysqlInstanceList?vpcNo=${data.ncloud_vpc.vpc.id}&subnetNo=${data.ncloud_subnet.vpc_pub_subnet.id}&cloudMysqlServiceName=${var.cdbmysql_name}&responseFormatType=json" |grep cloudMysqlInstanceNo |cut -d "\"" -f4)

${var.path_module}/cdb_mysql.sh POST "/vmysql/v2/deleteCloudMysqlInstance?cloudMysqlInstanceNo=$CDB_NUM&responseFormatType=json"
        EOF
    }
}
