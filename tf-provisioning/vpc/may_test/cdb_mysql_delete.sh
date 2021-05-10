#!/bin/bash
function makeSignature() {
nl=$'\\n'

TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
ACCESSKEY="$accessKey"
SECRETKEY="$secretKey"

SIG="$METHOD"' '"$URI"${nl}
SIG+="$TIMESTAMP"${nl}
SIG+="$ACCESSKEY"
echo -n -e $SIG
SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)
}

accessKey="A2A482B25508A780DA48"
secretKey="046B137ABC1BF65F269EF1E0997B1A55282C3A79"
apiUrl="https://ncloud.apigw.ntruss.com"

METHOD=$1
URI=$2
makeSignature $1 $2
echo $SIGNATURE

curl -i -X $METHOD \
-H "Content-Type:application/json" \
-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
-H "x-ncp-iam-access-key:$accessKey" \
-H "x-ncp-apigw-signature-v2:$SIGNATURE" \
-d "cloudDBServerInstanceNo=6677058&responseFormatType=json" \
-d "$3" \
"${apiUrl}${URI}" 2>>/dev/null
exit $?