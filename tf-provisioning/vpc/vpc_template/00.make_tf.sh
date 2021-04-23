cd ./01.vpc
terraform init
terraform apply -auto-approve
cd ../02.nacl
terraform init
terraform apply -auto-approve
