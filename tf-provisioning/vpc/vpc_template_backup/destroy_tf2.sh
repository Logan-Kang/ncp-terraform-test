# make_tf.sh을 실행하다가 문제가 생겼을 때 destroy가 필요할 시 해당 스크립트 실행해주세요
# tfstate 삭제 방지
cd ./13.cdb-mysql-delete
terraform init
export TF_VAR_path_module=$(pwd)
terraform apply -auto-approve
terraform destroy -auto-approve
sleep 600
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
terraform destroy -auto-approve
cd ../11.lb
terraform destroy -auto-approve
cd ../10.lb-tg
terraform destroy -auto-approve
cd ../09.server-exechost3-addnas/09-1.detach-nas
terraform init
terraform apply -auto-approve
terraform destroy -auto-approve
sleep 120
cd ..
terraform destroy -auto-approve
cd ../08.server-exechost2-addstg/08-1.detach-storage
terraform init
terraform apply -auto-approve
terraform destroy -auto-approve
sleep 120
cd ..
terraform destroy -auto-approve
cd ../08.server-exechost1-nrml
terraform destroy -auto-approve
cd ../07.server-bastion-public
terraform destroy -auto-approve
cd ../06.natgw
terraform destroy -auto-approve
cd ../05.init-script
terraform destroy -auto-approve
cd ../04.acg
terraform destroy -auto-approve
cd ../03.subnet
terraform destroy -auto-approve
cd ../02.nacl
terraform destroy -auto-approve
cd ../01.vpc
terraform destroy -auto-approve
