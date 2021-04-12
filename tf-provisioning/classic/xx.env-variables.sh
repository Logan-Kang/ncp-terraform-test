#!/bin/bash
# 해당 테스트는 리얼 환경에서 테스트를 진행하며, 클래식 환경이므로 site = public, gov에서 진행 가능합니다.
# 밑의 TF_VAR_~~ 명령을 이용하여 terraform에서 사용하는 변수에 환경변수 항목을 추가할 수 있습니다.

export TF_VAR_access_key="zfJRSMK~~~~~"
export TF_VAR_secret_key="veXLY2s3~~~~~"
export TF_VAR_site="public"

echo $TF_VAR_access_key
echo $TF_VAR_secret_key

