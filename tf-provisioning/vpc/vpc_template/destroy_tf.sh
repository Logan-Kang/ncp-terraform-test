cd ./03.subnet
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../02.nacl
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../01.vpc
terraform destroy -auto-approve
rm -rf .terraform terraform.tfstate terraform.tfstate.backup