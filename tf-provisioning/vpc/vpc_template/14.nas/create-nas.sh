#!/bin/bash
Usage(){
    echo "./$0 <nas-name> <vol-size> <vol-type> <zone>"
    exit 1
}

if [ $# -ne 4 ]; then
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
 
nas_name=$1
nas_size=$2
nas_type=$3
nas_zone=$4
METHOD=GET
URI="/vnas/v2/deleteNasVolumeInstances?zoneCode=$nas_zone&volumeName=$nas_name&volumeAllotmentProtocolTypeCode=$nas_type&volumeSize=500"
makeSignature $METHOD $URI

result=`curl -i -X $METHOD \
-H "accept:application/json" \
-H "Content-Type:application/x-www-form-urlencoded" \
-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
-H "x-ncp-iam-access-key:$TF_VAR_access_key" \
-H "x-ncp-apigw-signature-v2:$SIGNATURE" \
"${apiUrl}${URI}" 2>>/dev/null`

exit $?