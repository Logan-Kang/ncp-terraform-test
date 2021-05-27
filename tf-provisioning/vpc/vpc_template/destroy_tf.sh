cd ./11.lb
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
# git update를 위해 tfstate까지 삭제한 파일입니다. 사용에 주의를 요합니다.
# make_tf.sh 실행하다가 문제가 발생하여 원복이 필요할 경우 destroy_tf2.sh을 이용하세요.
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