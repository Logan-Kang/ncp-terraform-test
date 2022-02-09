D=`date "+%Y-%m-%d %H:%M:%S"`

cd ./01.vpc
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../02.nacl
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../03.subnet
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../04.acg
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../05.init-script
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../06.natgw
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../07.server-bastion-public
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../08.server-exechost1-nrml
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../08.server-exechost2-addstg
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../09.server-exechost3-addnas
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../10.lb-tg
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../11.lb
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-apply.log
  #echo -e "\n"
  exit; 
fi