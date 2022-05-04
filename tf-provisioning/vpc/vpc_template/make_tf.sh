D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ./tf-apply.log
echo "$D APPLY START" >> ./tf-apply.log

: <<'END'
### vpc ###
cd ./01.vpc
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D VPC CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### nacl ###
cd ../02.nacl
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D NACL CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### subnet ### 
cd ../03.subnet
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D SUBNET CREATE(PUB,PRIV,LB)" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### acg ### 
cd ../04.acg
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D ACG CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi


### init script ### 
cd ../05.init-script
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D INIT SCRIPT CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### nat gateway ### 
cd ../06.natgw
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D NAT GATEWAY CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### bastion server ### 
cd ../07.server-bastion-public
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D BASTION SERVER(PUB) CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### exechost1 server(normal) ### 
cd ../08.server-exechost1-nrml
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D EXECHOST1 SERVER(NORMAL) CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### exechost2 server(add storage) ### 
cd ../08.server-exechost2-addstg
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D EXECHOST2 SERVER(ADD STORAGE) CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### exechost3 server(add nas storage) ### 
cd ../09.server-exechost3-addnas
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D EXECHOST3 SERVER(ADD NAS) CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### load balancer target group ### 
cd ../10.lb-tg
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D LB TARGET GROUP CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit; 
fi

### load balancer(application, network, network proxy) ### 
cd ../11.lb
END
cd ./11.lb
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D LOAD BALANCER CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
if [ $? != 0 ]; 
then
  echo "$D" >> ../tf-error-apply.log
  #echo "${TF_APPLY}" >> ../tf-error-apply.log
  #echo "${TF_APPLY}" | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  exit 0;
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
fi

### CDB MySQL Create ### 
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
D=`date "+%Y-%m-%d %H:%M:%S"`
terraform init
echo "$D CDB MYSQL CREATE" >> ../tf-apply.log
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-apply.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit;
fi
