#!/bin/bash
Usage(){
    echo "./$0 <set|del> <targetNasNo> <serverInstanceNo>"
    exit 1
}

if [ $# -ne 3 ]; then
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

operType=$1
nasNo=$2
serverNo=$3
if [ "$operType" = "set" ]; then
    METHOD=GET
    URI="/vnas/v2/addNasVolumeAccessControl?nasVolumeInstanceNo=$nasNo&serverInstanceNoList.1=$serverNo&responseFormatType=json"
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
elif [ "$operType" = "del" ]; then
    METHOD=GET
    URI="/vnas/v2/removeNasVolumeAccessControl?nasVolumeInstanceNo=$nasNo&serverInstanceNoList.1=$serverNo&responseFormatType=json"
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
fi
