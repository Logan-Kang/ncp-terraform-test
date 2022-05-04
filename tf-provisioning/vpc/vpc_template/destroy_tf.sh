# make_tf.sh을 실행하다가 문제가 생겼을 때 destroy가 필요할 시 해당 스크립트 실행해주세요
# tfstate 삭제 방지
D=`date "+%Y-%m-%d %H:%M:%S"`
echo -e "\n" >> ./tf-destroy.log
echo "$D DESTROY START" >> ./tf-destroy.log

#: <<'END'

cd ./13.cdb-mysql-delete
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D CDB MYSQL DESTROY" >> ../tf-destroy.log
terraform init
export TF_VAR_path_module=$(pwd)
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-destroy.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
sleep 600
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../11.lb
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D LOAD BALANCER DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../10.lb-tg
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D LB TARGET GROUP DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../09.server-exechost3-addnas/09-1.detach-nas
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D EXECHOST3 SERVER & NAS DESTROY" >> ../tf-destroy.log
terraform init
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-destroy.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
sleep 120
cd ..
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  #echo -e "\n"
  exit; 
fi

cd ../08.server-exechost2-addstg/08-1.detach-storage
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D EXECHOST2 SERVER & ADD-STORAGE DESTROY" >> ../tf-destroy.log
terraform init
TF_APPLY=$(terraform apply -auto-approve)
echo "${TF_APPLY}" >> ../tf-destroy.log
echo "${TF_APPLY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_APPLY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi
sleep 120
cd ..
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../08.server-exechost1-nrml
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D EXECHOST1 SERVER(NORMAL) DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ./07.server-bastion-public
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D BASTION SERVER DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../06.natgw
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D NAT GATEWAY DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../05.init-script
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D INIT-SCRIPT DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../04.acg
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D ACG DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../03.subnet
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D SUBNET DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../02.nacl
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D NACL DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi

cd ../01.vpc
D=`date "+%Y-%m-%d %H:%M:%S"`
echo "$D VPC DESTROY" >> ../tf-destroy.log
TF_DESTROY=$(terraform destroy -auto-approve)
echo "${TF_DESTROY}" >> ../tf-destroy.log
echo "${TF_DESTROY}"
if [ $? != 0 ]; 
then
  echo "$D ${TF_DESTROY}"  | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g" >> ../tf-error-destroy.log
  exit; 
fi