#!/bin/bash

source .env

# Get the public IP of the current machine
HOST_IP=$(curl -s ifconfig.io/ip)

# Update the Cloudflare DNS record with the current IP
curl -s --request PUT \
  --url https://api.cloudflare.com/client/v4/zones/$CL_ZONE_ID/dns_records/$CL_DNS_ID \
  --header "Content-Type: application/json" \
  --header "X-Auth-Email: $CL_EMAIL" \
  --header "X-Auth-Key: $CL_API" \
  --data '{
  "type": "A",
  "name": "'"$CL_DNS"'",
  "content": "'"$HOST_IP"'",
  "proxied": true
}'

echo "Updated DNS record for $CL_DNS to IP $HOST_IP"
