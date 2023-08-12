#!/bin/bash
#
# Check that vk8s is ready before creating workload resources
#
echo "site name: $1"
echo "namespace: $2"
echo "provider_url: $3"

for x in `seq 1 120`; do
    site_state=$(curl --location --request GET --cert-type P12 --cert $VOLT_API_P12_FILE:$VES_P12_PASSWORD --url $3/config/namespaces/$2/virtual_k8ss/$1?response_format=GET_RSP_FORMAT_DEFAULT -H "content-type: application/json" -s | jq -r '.system_metadata.initializers.pending | length')
    echo "site state: $site_state"
if [ "$site_state" = "0" ]; then
   echo "ONLINE: $1 is online.  Safe to proceed. waited $x minutes"
   exit 0
else
    echo "$site_state: wait for $1 to be ONLINE before proceeding.  Waiting $x minutes"
    #exit 1
fi    
sleep 60;
done;
echo "$site_state: wait for $1 to be ONLINE before proceeding; timed out after 120 minutes"
exit 1;