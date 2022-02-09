# make_tf.sh을 실행하다가 문제가 생겼을 때 destroy가 필요할 시 해당 스크립트 실행해주세요
# tfstate 삭제 방지
cd ./13.cdb-mysql-delete
terraform init
export TF_VAR_path_module=$(pwd)
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
sleep 600
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../11.lb
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../10.lb-tg
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../09.server-exechost3-addnas/09-1.detach-nas
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
sleep 120
cd ..
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../08.server-exechost2-addstg/08-1.detach-storage
terraform init
TF_APPLY=$(terraform apply -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
sleep 120
cd ..
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../08.server-exechost1-nrml
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../07.server-bastion-public
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../06.natgw
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../05.init-script
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../04.acg
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../03.subnet
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../02.nacl
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
cd ../01.vpc
TF_DESTROY=$(terraform destroy -auto-approve 2>&1)
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi
