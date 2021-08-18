export TF_VAR_access_key="A2A482B25508A780DA48"
export TF_VAR_secret_key="046B137ABC1BF65F269EF1E0997B1A55282C3A79"
export TF_VAR_site="public"

export TF_VAR_region="KR"
export TF_VAR_zone="KR-2"

export TF_VAR_num=3 # 서버 생성 개수

export TF_VAR_account_name="dayeon"

export TF_VAR_inbound_acg='[["TCP", "0.0.0.0/0", "22", "SSH", ""],["TCP", "0.0.0.0/0", "80", "HTTP", ""],["TCP", "0.0.0.0/0", "3389", "RDP", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""],["TCP", "0.0.0.0/0", "6044", "Bastion", ""]]'
export TF_VAR_outbound_acg='[["TCP", "0.0.0.0/0", "1-65535", "TCP all", ""],["UDP", "0.0.0.0/0", "1-65535", "UDP all", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""]]'

export TF_VAR_linux_password='csi!@#123'

export TF_VAR_server_spec_bastion='SPSVRSTAND000004' # 2vCPU, 4GB Mem, HDD 50GB
export TF_VAR_server_image_bastion='SPSW0LINUX000046' # centos-7.3-64
export TF_VAR_server_spec_tester='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_tester='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
##(server image list)
  ##"SW.VSVR.OS.LNX64.CNTOS.0703.B050" = "centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0708.B050" = "CentOS 7.8 (64-bit)"
  ##"SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050" = "ubuntu-16.04-64-server"
  ##"SW.VSVR.OS.WND64.WND.SVR2016EN.B100" = "Windows Server 2016 (64-bit) English Edition"

## Application LB
export TF_VAR_tg_protocol="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_tg_port='80' 
export TF_VAR_hc_protocol="HTTP" # HTTP/HTTPS/TCP/PROXY_TCP
export TF_VAR_hc_port='80'
export TF_VAR_hc_url="/index.html" # nlb,proxylb는 빈칸 지정

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