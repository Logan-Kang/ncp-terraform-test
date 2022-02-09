# terraform으로 구성한 기록이 모두 삭제되므로 주의해서 사용해야 합니다.
# destroy 이후 사용하는 것을 권고합니다.

cd ./13.cdb-mysql-delete
rm -rf .terraform terraform.tfstate terraform.tfstate.backup output.apistate .terraform.lock.hcl
cd ../12.cdb-mysql-create
rm -rf .terraform terraform.tfstate terraform.tfstate.backup output.apistate
cd ../11.lb
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../10.lb-tg
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../09.server-exechost3-addnas/09-1.detach-nas
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ..
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../08.server-exechost2-addstg/08-1.detach-storage
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ..
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../08.server-exechost1-nrml
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../07.server-bastion-public
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../06.natgw
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../05.init-script
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../04.acg
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../03.subnet
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../02.nacl
rm -rf .terraform terraform.tfstate terraform.tfstate.backup
cd ../01.vpc
rm -rf .terraform terraform.tfstate terraform.tfstate.backup