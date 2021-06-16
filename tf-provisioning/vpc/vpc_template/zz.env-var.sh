export TF_VAR_access_key="lGvLOT0aA07QCEgHYjSO"
export TF_VAR_secret_key="SHRKBeH2iiOAWV5zIl7l1S8a6oUWnxkiQLNicAh9"
export TF_VAR_site="fin"

export TF_VAR_region="FKR"
export TF_VAR_zone="FKR-1"

export TF_VAR_vpc_num="01"
export TF_VAR_vpc_cidr="10.200.0.0/16"
export TF_VAR_pub_subnet_cidr="10.200.10.0/24"
export TF_VAR_priv_subnet_cidr="10.200.20.0/24"
export TF_VAR_lb_subnet_cidr="10.200.30.0/24"

export TF_VAR_account_name="kcg"

export TF_VAR_inbound_acg='[["TCP", "0.0.0.0/0", "80", "HTTP", ""],["TCP", "0.0.0.0/0", "3389", "RDP", ""]]'
export TF_VAR_outbound_acg='[["TCP", "0.0.0.0/0", "1-65535", "TCP all", ""],["UDP", "0.0.0.0/0", "1-65535", "UDP all", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""]]'

export TF_VAR_linux_password='csi!@#123'

export TF_VAR_server_spec_bastion='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_bastion='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
export TF_VAR_server_spec_exechost='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_exechost='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
##(server image list)
  ##"SW.VSVR.OS.LNX64.CNTOS.0703.B050" = "centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0708.B050" = "CentOS 7.8 (64-bit)"
  ##"SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050" = "ubuntu-16.04-64-server"
  ##"SW.VSVR.OS.WND64.WND.SVR2016EN.B100" = "Windows Server 2016 (64-bit) English Edition"

#---------- CDB MYSQL(API) ----------#
export TF_VAR_api_url='https://fin-ncloud.apigw.fin-ntruss.com'# finance
#export TF_VAR_api_url='https://ncloud.apigw.gov-ntruss.com' # gov
#export TF_VAR_api_url='https://ncloud.apigw.ntruss.com' # public

export TF_VAR_cdbmysql_name='kcg-cdb2'    # DB cluster name
export TF_VAR_cdbmysql_prefix='kcg-cdb2'  # DB server name prefix
export TF_VAR_cdbmysql_username='student' # DB username
export TF_VAR_cdbmysql_userpwd='Qwer1234!@' # DB user password
export TF_VAR_cdbmysql_hostIP='%25' # host IP(ALL)
export TF_VAR_cdbmysql_dbname='test2' # DB database name
export TF_VAR_path_module=$(pwd)
export TF_VAR_cdbmysql_imagecode="SW.VDBAS.DBAAS.LNX64.CNTOS.0708.MYSQL.5732.B050"  # image code(centos 7.8/mysql 5.7.32)
export TF_VAR_cdbmysql_prdcode="SVR.VDBAS.STAND.C002.M004.NET.HDD.B050.G001"        # product code(2vCPU/4GBMemory)
export TF_VAR_cdbmysql_isHa=true    # set High Availability
export TF_VAR_cdbmysql_isMultiZone=false  # set Multi Zone
export TF_VAR_cdbmysql_port='3306'  # set mysql port(3306 or 10000~20000)

#---------- LB(choose 1 in 3) ----------#
## Application LB
export TF_VAR_tg_protocol="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port='80' 
export TF_VAR_hc_protocol="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port='80'
export TF_VAR_hc_url="/" # nlb,proxylb는 빈칸 지정

export TF_VAR_lb_name="alb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='APPLICATION' # APPLICATION/NETWORK/NETWORK_PROXY
export TF_VAR_listener_protocol="HTTP" # HTTP/HTTPS
export TF_VAR_listener_port='80'

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=false

## Network LB
export TF_VAR_tg_protocol="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port='80' 
export TF_VAR_hc_protocol="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port='80'
export TF_VAR_hc_url="" # nlb,proxylb는 빈칸 지정

export TF_VAR_lb_name="nlb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='NETWORK' # APPLICATION/NETWORK/NETWORK_PROXY
export TF_VAR_listener_protocol="TCP" 
export TF_VAR_listener_port='80'

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=false

# Network Proxy LB
export TF_VAR_tg_protocol="PROXY_TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port='80' 
export TF_VAR_hc_protocol="TCP" # HTTP/HTTPS/TCP
export TF_VAR_hc_port='80'
export TF_VAR_hc_url="" # nlb,proxylb는 빈칸 지정

export TF_VAR_lb_name="proxylb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='NETWORK_PROXY' # APPLICATION/NETWORK/NETWORK_PROXY
export TF_VAR_listener_protocol="TCP" # TCP/TLS
export TF_VAR_listener_port='80'

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=true


echo $TF_VAR_access_key
echo $TF_VAR_secret_key
