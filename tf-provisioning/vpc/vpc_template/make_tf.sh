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
cd ../08.server-bastion
terraform init
terraform apply -auto-approve
cd ../09.server-exechost
terraform init
terraform apply -auto-approve
cd ../10.lb-tg
terraform init
terraform apply -auto-approve
cd ../11.lb
terraform init
terraform apply -auto-approve
cd ../12.cdb-mysql
export TF_VAR_path_module=$(pwd)
terraform init
terraform apply -auto-approve

cd ../14*
nas_number=`./create-nas.sh $nas_name $nas_size $nas_type`
if [ "$nas_number" = "Failed" ]; then
    echo "Make Nas Failed"
else
    echo $nas_number > nas_number
    server1_No=`cat ../09.server-exechost/terraform.tfstate  | grep \"instance_no\" | awk -F\" '{print $4}'`
    ./access-control.sh set $nas_number $server1_No
fi