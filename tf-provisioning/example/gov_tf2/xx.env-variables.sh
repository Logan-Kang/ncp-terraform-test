#!/bin/bash

export TF_VAR_access_key="zfJRSMK5xT8NAjaWH6EZ"
export TF_VAR_secret_key="veXLY2s3l07jrdwfgR2TsyovQdal1CIJ3ev7PO3J"

echo $TF_VAR_access_key
echo $TF_VAR_secret_key


# 베타 환경 진행시 입력 필요
export NCLOUD_API_GW=https://ncloud.beta-apigw.ntruss.com
export TF_VAR_access_key=""
export TF_VAR_secret_key=""
export TF_VAR_support_vpc=true

#로그인 키를 테라폼으로 생성시 키를 확인할 수 없으므로,
#ncloud cli로 확인 후 해당 키 명을 사용

#./ncloud server createLoginKey --keyName testkey > result
#echo -e `cat result  | grep privateKey | awk -F':' '{print $2}'` | tr -d "\"" >> ~/Documents/vscode/ncp_terraform/testkey.pem
#확인
#./ncloud server getLoginKeyList

#./ncloud server createLoginKey --keyName testkey > result
#echo -e `cat result  | grep privateKey | awk -F':' '{print $2}'` | tr -d "\"" >> ~/Documents/vscode/ncp_terraform/testkey.pem

terraform tfstate 파일에서 확인 가능
