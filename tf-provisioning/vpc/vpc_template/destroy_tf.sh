cd ./11.lb/111.alb
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../../10.lb-tg/101.alb-tg
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../../09.server-tester
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../08.server-ansible
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