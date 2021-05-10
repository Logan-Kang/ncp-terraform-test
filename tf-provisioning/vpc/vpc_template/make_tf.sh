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
cd ../07.natgw
terraform init
terraform apply -auto-approve
cd ../08.server-ansible
terraform init
terraform apply -auto-approve
cd ../09.server-tester
terraform init
terraform apply -auto-approve
cd ../10.lb-tg
terraform init
terraform apply -auto-approve
cd ../11.lb
terraform init
terraform apply -auto-approve