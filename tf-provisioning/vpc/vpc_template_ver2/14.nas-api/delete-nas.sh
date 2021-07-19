#!/bin/bash
Usage(){
    echo "./$0 <nas-instanceNo"
    exit 1
}

if [ $# -ne 1 ]; then
    Usage
fi

function makeSignature() {
    nl=$'\\n'
    
    TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
    ACCESSKEY="$TF_VAR_access_key"
    SECRETKEY="$TF_VAR_secret_key"
    
    SIG="$METHOD"' '"$URI"${nl}
    SIG+="$TIMESTAMP"${nl}
    SIG+="$ACCESSKEY"

    SIGNATURE=$(echo -n -e $SIG|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)
    }

apiUrl="$TF_VAR_api_url"
 
nas_instance_no=$1

METHOD=GET
URI="/vnas/v2/deleteNasVolumeInstances?nasVolumeInstanceNoList.1=$nas_instance_no&responseFormatType=json"
makeSignature $METHOD $URI

result=`curl -i -X $METHOD \
-H "accept:application/json" \
-H "Content-Type:application/x-www-form-urlencoded" \
-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
-H "x-ncp-iam-access-key:$TF_VAR_access_key" \
-H "x-ncp-apigw-signature-v2:$SIGNATURE" \
"${apiUrl}${URI}" 2>>/dev/null`

ret=`echo "$result" | grep returnMessage`
if [ -z "$ret" ]; then
    echo "Failed"
else
    resultStr=`echo $ret | awk -F\" '{print $4}'`
    if [ "$resultStr" = "success" ]; then
        echo "success"
    else
        echo "Failed"
    fi
fi