export TF_VAR_access_key="lGvLOT0aA07QCEgHYjSO"
export TF_VAR_secret_key="SHRKBeH2iiOAWV5zIl7l1S8a6oUWnxkiQLNicAh9"
export TF_VAR_site="fin"

export TF_VAR_zone="FKR-1"

export TF_VAR_vpc_num="01"
export TF_VAR_vpc_cidr="10.200.0.0/16"
export TF_VAR_pub_subnet_cidr="10.200.10.0/24"
export TF_VAR_priv_subnet_cidr="10.200.20.0/24"
export TF_VAR_lb_subnet_cidr="10.200.30.0/24"

export TF_VAR_account_name="kcg"

export TF_VAR_inbound_acg='[["TCP", "0.0.0.0/0", "22", "SSH", ""],["TCP", "0.0.0.0/0", "80", "HTTP", ""],["TCP", "0.0.0.0/0", "3389", "RDP", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""]]'
export TF_VAR_outbound_acg='[["TCP", "0.0.0.0/0", "1-65535", "TCP all", ""],["UDP", "0.0.0.0/0", "1-65535", "UDP all", ""],["ICMP", "0.0.0.0/0", null, "ICMP", ""]]'

export TF_VAR_linux_password='csi!@#123'

export TF_VAR_server_spec='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
export TF_VAR_server_spec_tester='SVR.VSVR.STAND.C002.M004.NET.HDD.B050.G001'
export TF_VAR_server_image_tester='SW.VSVR.OS.LNX64.CNTOS.0708.B050'
##(server image list)
  ##"SW.VSVR.OS.LNX64.CNTOS.0703.B050" = "centos-7.3-64"
  ##"SW.VSVR.OS.LNX64.CNTOS.0708.B050" = "CentOS 7.8 (64-bit)"
  ##"SW.VSVR.OS.LNX64.UBNTU.SVR1604.B050" = "ubuntu-16.04-64-server"
  ##"SW.VSVR.OS.WND64.WND.SVR2016EN.B100" = "Windows Server 2016 (64-bit) English Edition"

echo $TF_VAR_access_key
echo $TF_VAR_secret_key