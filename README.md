## ncp-iac
> Creator: chikuk.park
> Date: 2021/4/12

## Description


# Terraform Code for 5월 변경작업

여기 작성된 코드는 5월 변경 작업 중 '여의도 평촌 회선교체 작업 관련 테스트 및 모니터링'을 위한 사전 인프라 프로비저닝 코드입니다.

### 준비사항

해당 문서 내에는 xx.env-var.sh로 표현하였으며, **리눅스 환경변수 설정**을 통해 입력값을 임시로 입력하였습니다.

- 추후 Jenkins를 이용한 인프라 프로비저닝 자동화 수행을 위해서 환경변수로 임시 설정하였습니다,

> Linux OS 사용 방법으로 작성하였습니다.
> 
> - export TF_VAR_access_key="lGvL
> - export TF_VAR_secret_key="SHRK

### 사용방법

 >1. xx.env-var.sh 내 코드들을 통해 환경변수를 선언합니다.
 >2. Terraform을 초기화합니다. 
      `terraform init`
 >3. Terraform plan을 통해 코드 수행이 정상적으로 가능한지 확인합니다.
      `terraform plan`
 >4. Terraform apply를 통해 정상 수행 가능한 코드를 수행합니다.
 -auto-approve 옵션을 이용하여 별도 확인없이 곧바로 수행 또한 가능합니다.
 `terraform apply (-auto-approve)`
 

### 코드 내 설정 내용
>1. VPC 생성
>2. NACL 생성
>3. Subnet 생성(Public, Private, LB)
>4. 서버 생성 전 ACG 구성
>5. 서버 구성을 위한 init-script 구성(root password 변경)
>6. 서버 구성을 위한 login key 구성(root password 분실 시 사용 가능)
>7. Private Subnet에 사용 가능한 NAT Gateway 구성 및 route table 등록
>8. 서버 구성 - ansible
>해당 서버는 성능테스트 또는 기타 테스트 결과를 수집하여 메인 Logstash 서버로 전송합니다.
>9. 서버 구성 - test vm
>10. Application Load Balancer 및 Listener 구성
>11. Application Load Balancer 용 Target Group 구성 및 test vm 등록

### 추가 구성

위 코드는 현재 하나의 폴더 내 구성되어 한번에 실행되며, 추후 분리구성하여 템플릿화를 수행할 예정입니다.