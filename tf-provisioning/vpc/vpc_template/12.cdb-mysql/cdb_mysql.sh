#!/bin/bash
function makeSignature() {
nl=$'\\n'
 
TIMESTAMP=$(echo $(($(date +%s%N)/1000000)))
ACCESSKEY="$TF_VAR_access_key"
SECRETKEY="$TF_VAR_secret_key"
 
SIG="$METHOD"' '"$URI"${nl}
SIG+="$TIMESTAMP"${nl}
SIG+="$ACCESSKEY"
echo -n -e $SIG
SIGNATURE=$(echo -n -e "$SIG"|iconv -t utf8 |openssl dgst -sha256 -hmac $SECRETKEY -binary|openssl enc -base64)
}

apiUrl="$TF_VAR_api_url"
 
METHOD=$1
URI=$2
makeSignature $1 $2
echo $SIGNATURE
 
curl -i -X $METHOD \
-H "accept:application/json" \
-H "Content-Type:application/x-www-form-urlencoded" \
-H "x-ncp-apigw-timestamp:$TIMESTAMP" \
-H "x-ncp-iam-access-key:$TF_VAR_access_key" \
-H "x-ncp-apigw-signature-v2:$SIGNATURE" \
-d "$3" \
"${apiUrl}${URI}" 2>>/dev/null
exit $?