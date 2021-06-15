# git update를 위해 tfstate까지 삭제한 파일입니다. 사용에 주의를 요합니다.
# make_tf.sh 실행하다가 문제가 발생하여 원복이 필요할 경우 destroy_tf2.sh을 이용하세요.
# (중요!)진행하기 전에 환경변수가 설정되어있는지 필수로 확인합니다!!
cd ./13.cdb-mysql-delete
export TF_VAR_path_module=$(pwd)
terraform destroy -auto-approve
terraform apply -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../12.cdb-mysql-create
export TF_VAR_path_module=$(pwd)
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup output.apistate
cd ../11.lb
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../10.lb-tg
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../09.server-exechost
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../08.server-bastion
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../07.natgw
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../05.init-script
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../04.acg
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../03.subnet
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../02.nacl
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../01.vpc
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup