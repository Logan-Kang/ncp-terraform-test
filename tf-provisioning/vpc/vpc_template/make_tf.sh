cd ./01.vpc
terraform init
terraform apply -auto-approve
cd ../02.nacl
terraform init
terraform apply -auto-approve
cd ../03.subnet
terraform init
terraform apply -auto-approve
cd ../04.acg
terraform init
terraform apply -auto-approve
cd ../05.init-script
terraform init
terraform apply -auto-approve
cd ../06.login-key
terraform init
terraform apply -auto-approve