cd ./07.natgw
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../06.login-key
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