### Default ###
# 로그 설정
export TF_LOG=

# Provider 환경변수 설정
export TF_VAR_access_key="gzQg15lH2JaYa57ed8zm"
export TF_VAR_secret_key="ijyVWwhzfL6wPPqjnRCMGXQAZJDxPFJETSJ49d5L"
export TF_VAR_site="fin"
export TF_VAR_region="FKR"
export TF_VAR_support_vpc=true

## 기본 변수 ##
export TF_VAR_account_name="kcg"

## VPC & Subnet (with default NACL) ##
export TF_VAR_vpc_num="01"
export TF_VAR_vpc_cidr="10.200.0.0/16"

# zone은 첫번째 항목으로 public subnet 생성
# zone 개수와, priv_subnet 개수 일치해야함(count 동일)
export TF_VAR_pub_subnet_cidr="10.200.10.0/24"
export TF_VAR_num_of_priv_subnets=2
export TF_VAR_zone='["FKR-2","FKR-1"]'
export TF_VAR_priv_subnet_cidr='["10.200.20.0/24","10.200.30.0/24"]'
export TF_VAR_lb_subnet_cidr='["10.200.110.0/24","10.200.120.0/24"]'

## ACG ##
export TF_VAR_inbound_acg='[["TCP", "0.0.0.0/0", "80", "HTTP", ""],["TCP", "0.0.0.0/0", "3389", "RDP", ""]]'
export TF_VAR_outbound_acg='[["TCP", "0.0.0.0/0", "1-65535", "TCP all", ""],["UDP", "0.0.0.0/0", "1-65535", "UDP all", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""]]'

## init-script ##
export TF_VAR_linux_password='csi!@#123'

## Bastion Server(Public) ##
export TF_VAR_server_spec_bastion='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_bastion='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
export TF_VAR_init_script_bastion="tf-init-bastion-centos"

## Exechost1 - normal(private) ##
export TF_VAR_exechost1_priv_subnet="tf-kcg-vpc01-priv-subnet2"
export TF_VAR_num_of_exechost1=1
export TF_VAR_init_script_exechost1="tf-init-exechost-centos"
export TF_VAR_server_spec_exechost1='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_exechost1='SW.VSVR.OS.LNX64.CNTOS.0708.B050'

## Exechost2 - addstg(private) ##
export TF_VAR_exechost2_priv_subnet="tf-kcg-vpc01-priv-subnet2"
export TF_VAR_num_of_exechost2=1
export TF_VAR_init_script_exechost2="tf-init-exechost-centos"
export TF_VAR_server_spec_exechost2='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_exechost2='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
export TF_VAR_exechost2_addstg_size="100"
export TF_VAR_exechost2_addstg_mountdir='/mnt/addstg'

## Exechost3 - addnas(private) ##
export TF_VAR_exechost3_priv_subnet="tf-kcg-vpc01-priv-subnet1"
export TF_VAR_num_of_exechost3=0
export TF_VAR_server_spec_exechost3='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_exechost3='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
export TF_VAR_init_script_exechost3="tf-init-exechost-centos"
export TF_VAR_exechost3_nas_name_postfix="kcgnas"
export TF_VAR_exechost3_nas_size=500
export TF_VAR_exechost3_nas_protocol="NFS"  # NFS|CIFS
export TF_VAR_exechost3_cifs_user_name=""
export TF_VAR_exechost3_cifs_user_password=""
export TF_VAR_exechost3_nas_encrypted=false
export TF_VAR_exechost3_nas_mountdir='/mnt/nas'

##(server image list)
  ##"SW.VSVR.OS.LNX64.CNTOS.0703.B050" = "centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0708.B050" = "CentOS 7.8 (64-bit)"
  ##"SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050" = "ubuntu-16.04-64-server"
  ##"SW.VSVR.OS.WND64.WND.SVR2016EN.B100" = "Windows Server 2016 (64-bit) English Edition"

#---------- LB(choose 1 in 3) ----------#
## Application LB

# Target Group
export TF_VAR_tg_protocol_exechost1="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost1='80' 
export TF_VAR_hc_protocol_exechost1="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost1='80'
export TF_VAR_hc_url_exechost1="/" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost2="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost1='88' 
export TF_VAR_hc_protocol_exechost2="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost2='80'
export TF_VAR_hc_url_exechost2="/" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost3="HTTPS" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost1='443' 
export TF_VAR_hc_protocol_exechost3="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost3='80'
export TF_VAR_hc_url_exechost3="/" # nlb,proxylb는 빈칸 지정

# Load Balancer
export TF_VAR_lb_name="alb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='APPLICATION' # APPLICATION/NETWORK/NETWORK_PROXY

export TF_VAR_listener_protocol_exechost1="HTTP" # HTTP/HTTPS
export TF_VAR_listener_port_exechost1='80'
export TF_VAR_listener_protocol_exechost2="" # HTTP/HTTPS
export TF_VAR_listener_port_exechost2='80'
export TF_VAR_listener_protocol_exechost3="HTTP" # HTTP/HTTPS
export TF_VAR_listener_port_exechost3='443'

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=false

## Network LB
# Target Group
export TF_VAR_tg_protocol_exechost1="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost1='80' 
export TF_VAR_hc_protocol_exechost1="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost1='80'
export TF_VAR_hc_url_exechost1="" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost2="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost2='81' 
export TF_VAR_hc_protocol_exechost2="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost2='80'
export TF_VAR_hc_url_exechost2="" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost3="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost3='82' 
export TF_VAR_hc_protocol_exechost3="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost3='80'
export TF_VAR_hc_url_exechost3="" # nlb,proxylb는 빈칸 지정

# Load Balancer
export TF_VAR_lb_name="nlb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='NETWORK' # APPLICATION/NETWORK/NETWORK_PROXY

export TF_VAR_listener_protocol_exechost1="TCP" # HTTP HTTPS TCP TLS
export TF_VAR_listener_port_exechost1='80'
export TF_VAR_listener_protocol_exechost2="TCP" # HTTP HTTPS TCP TLS
export TF_VAR_listener_port_exechost2='81'
export TF_VAR_listener_protocol_exechost3="" # HTTP HTTPS TCP TLS
export TF_VAR_listener_port_exechost3=''

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=false

## Network Proxy LB

# Target Group
export TF_VAR_tg_protocol_exechost1="PROXY_TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost1='80' 
export TF_VAR_hc_protocol_exechost1="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost1='80'
export TF_VAR_hc_url_exechost1="" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost2="PROXY_TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost2='81' 
export TF_VAR_hc_protocol_exechost2="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost2='80'
export TF_VAR_hc_url_exechost2="" # nlb,proxylb는 빈칸 지정

export TF_VAR_tg_protocol_exechost3="PROXY_TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port_exechost3='82' 
export TF_VAR_hc_protocol_exechost3="TCP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port_exechost3='80'
export TF_VAR_hc_url_exechost3="" # nlb,proxylb는 빈칸 지정

# Load Balancer
export TF_VAR_lb_name="proxylb" # alb/nlb/proxylb
export TF_VAR_lb_network_type='PUBLIC' # PUBLIC/PRIVATE
export TF_VAR_lb_type='NETWORK_PROXY' # APPLICATION/NETWORK/NETWORK_PROXY

export TF_VAR_listener_protocol_exechost1="TCP" # HTTP HTTPS TCP TLS
export TF_VAR_listener_port_exechost1='80'
export TF_VAR_listener_protocol_exechost2="" # HTTP/HTTPS
export TF_VAR_listener_port_exechost2=''
export TF_VAR_listener_protocol_exechost3="TCP" # HTTP/HTTPS
export TF_VAR_listener_port_exechost3='88'

export TF_VAR_use_sticky_session=false
export TF_VAR_use_proxy_protocol=true

#---------- NAS ----------#
export TF_VAR_nas_name_postfix="kcgnas"
export TF_VAR_nas_size=500 # 500 ~ 10000GB
export TF_VAR_nas_protocol="NFS" # NFS|CIFS
export TF_VAR_cifs_user_name=""
export TF_VAR_cifs_user_password=""
export TF_VAR_nas_encrypted=false
export TF_VAR_nas_mountdir='/mnt/nas'

#---------- CDB MYSQL(API) ----------#
export TF_VAR_api_url='https://fin-ncloud.apigw.fin-ntruss.com' # finance
#export TF_VAR_api_url='https://ncloud.apigw.gov-ntruss.com' # gov
#export TF_VAR_api_url='https://ncloud.apigw.ntruss.com' # public

export TF_VAR_mysql_priv_subnet="tf-kcg-vpc01-priv-subnet1"
export TF_VAR_cdbmysql_name='tf-kcg-cdb2'    # DB cluster name
export TF_VAR_cdbmysql_prefix='tf-kcg-cdb2'  # DB server name prefix
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
