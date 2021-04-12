export TF_VAR_access_key="F2DilhKOXWX6OulJ8g12"
export TF_VAR_secret_key="XlVwF7gT1clAw00y8JqXajwANJLKSImTZT0O98Oc"
export TF_VAR_site="public"

export TF_VAR_zone="KR-2"

#imagecode는 os code이며 아래의 예시는 centos-7.8-64입니다.
#사용하고자 하는 image에 대해 code와 연동이 필요합니다.
export TF_VAR_imagecode="SPSW0LINUX000139"

#speccode는 cpu,memory,disk 등 생성 스펙 관련 코드입니다.
#사용하고자 하는 spec에 대해 code와 연동이 필요합니다.
export TF_VAR_speccode="SPSVRSTAND000004" # vCPU 2개, 메모리 4GB, 디스크 50GB

# 생성 개수를 위해 num 사용
export TF_VAR_num=1


echo $TF_VAR_access_key
echo $TF_VAR_secret_key