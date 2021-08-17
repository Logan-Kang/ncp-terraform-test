# Terraform Provisioning(for Classic)
해당 코드는 NCP Classic 인프라 프로비저닝 자동화를 위한 Terraform 코드입니다.

### 준비사항

해당 문서 내에는 xx.env-var.sh로 표현하였으며, **리눅스 환경변수 설정**을 통해 입력값을 임시로 입력하였습니다.

- 추후 Jenkins를 이용한 인프라 프로비저닝 자동화 수행을 위해서 환경변수로 구성하였습니다.

> Linux OS 사용 방법으로 작성하였습니다.
> 
> - export TF_VAR_access_key="lGvL~~~"
> - export TF_VAR_secret_key="SHRK~~~"

### 사용방법

#### <생성 시>

 >1. xx.env-var.sh 내 코드들을 통해 환경변수를 선언합니다.
 >2. Terraform을 초기화합니다. 
      `terraform init`
 >3. Terraform plan을 통해 코드 수행이 정상적으로 가능한지 확인합니다.
      `terraform plan`
 >4. Terraform apply를 통해 정상 수행 가능한 코드를 수행합니다.
 -auto-approve 옵션을 이용하여 별도 확인없이 곧바로 수행 또한 가능합니다.
 `terraform apply (-auto-approve)`
 >5. 각 요소별로 템플릿화가 진행되어서 위 코드들을 한번에 수행할 수 있도록 make_tf.sh 파일을 통해 순서대로 생성되도록 제공할 예정입니다.

#### <반납 시>

 >1. xx.env-var.sh 내 코드들을 통해 환경변수를 선언합니다.
 >2. Terraform을 초기화합니다. 
      `terraform init`
 >3. Terraform plan을 통해 코드 수행이 정상적으로 가능한지 확인합니다.
      `terraform plan`
 >4. Terraform apply를 통해 정상 수행 가능한 코드를 수행합니다.
 -auto-approve 옵션을 이용하여 별도 확인없이 곧바로 수행 또한 가능합니다.
 `terraform destroy (-auto-approve)`
 >5. 각 요소별로 템플릿화가 진행되어서 위 코드들을 한번에 수행할 수 있도록 destroy_tf.sh 파일을 통해 순서대로 반납되도록 제공할 예정입니다.
 

### 코드 내 설정 내용
1. server 생성

.....진행중 ....