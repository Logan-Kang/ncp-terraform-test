# make_tf.sh을 실행하다가 문제가 생겼을 때 destroy가 필요할 시 해당 스크립트 실행해주세요
# tfstate 삭제 방지
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ./tf-destroy.log
echo "==========================================" >> ./tf-destroy.log
echo "$D DESTROY START" >> ./tf-destroy.log
echo "==========================================" >> ./tf-destroy.log

#: <<'END'
### CDB MySQL ###
cd ./13.cdb-mysql-delete
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D CDB MYSQL DESTROY" >> ../tf-destroy.log
terraform init
export TF_VAR_path_module=$(pwd)
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_APPLY}" >> ../tf-destroy.log
fi
D=`date "+%Y-%m-%d %H:%M:%S"`
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi
sleep 600
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### Load Balancer ###
cd ../11.lb
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D LOAD BALANCER DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### Load Balancer Target Group ###
cd ../10.lb-tg
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D LB TARGET GROUP DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### exechost3 server(add nas storage) ###  
cd ../09.server-exechost3-addnas/09-1.detach-nas
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D EXECHOST3 SERVER & NAS DESTROY" >> ../../tf-destroy.log
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_APPLY}" >> ../../tf-destroy.log
fi
D=`date "+%Y-%m-%d %H:%M:%S"`
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../../tf-destroy.log
fi
sleep 120
cd ..
D=`date "+%Y-%m-%d %H:%M:%S"`
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### exechost2 server(add storage) ###  
cd ../08.server-exechost2-addstg/08-1.detach-storage
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D EXECHOST2 SERVER & ADD-STORAGE DESTROY" >> ../../tf-destroy.log
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_APPLY}" >> ../../tf-destroy.log
fi
D=`date "+%Y-%m-%d %H:%M:%S"`
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../../tf-destroy.log
fi
sleep 120
cd ..
D=`date "+%Y-%m-%d %H:%M:%S"`
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### exechost1 server(normal) ###  
cd ../08.server-exechost1-nrml
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D EXECHOST1 SERVER(NORMAL) DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### Bastion Server ###  
cd ../07.server-bastion-public
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D BASTION SERVER DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### NAT Gateway ###  
cd ../06.natgw
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D NAT GATEWAY DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### INIT-SCRIPT ###  
cd ../05.init-script
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D INIT-SCRIPT DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### ACG ###  
cd ../04.acg
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D ACG DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### Subnet ###  
cd ../03.subnet
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D SUBNET DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### NACL ###  
cd ../02.nacl
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D NACL DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

### VPC ###  
cd ../01.vpc
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ../tf-destroy.log
echo "$D VPC DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? -ne 0 ]; then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit 0; 
else 
  echo "${TF_DESTROY}" >> ../tf-destroy.log
fi

cd ..
echo -e "\n" >> ./tf-destroy.log
echo "==========================================" >> ./tf-destroy.log
echo "$D DESTROY COMPLETE!" >> ./tf-destroy.log
echo "==========================================" >> ./tf-destroy.log