#!/bin/bash
set -e

LOG_PATH=/var/log/alexchesters-utils/dns-register.log

touch $LOG_PATH

function log {
  echo "[`date`] - $1"
}

IP_ADDRESS=$1
DNS_NAME=$2
HOSTED_ZONE_ID=$3
TTL=${4:-120}

if [ -z "$IP_ADDRESS" ]; then
  echo "[ERROR] Invalid usage"
  echo "Usage: dns-register.sh <IP_ADDRESS> <DNS_NAME> <HOSTED_ZONE_ID> <TTL = 120>"
  exit 1
fi

function upsert_record_set {
  log "upserting record set, pointing $DNS_NAME at $IP_ADDRESS"
  pushd /tmp

  echo "{
    \"Changes\": [
      {
        \"Action\": \"UPSERT\",
        \"ResourceRecordSet\": {
          \"Name\": \"$DNS_NAME\",
          \"Type\": \"A\",
          \"TTL\": $TTL,
          \"ResourceRecords\": [
            {
              \"Value\": \"$IP_ADDRESS\"
            }
          ]
        }
      }
    ]
  }" > batch.json

  aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE_ID \
    --change-batch file://batch.json

  popd

  log "successfully updated record set, $DNS_NAME is now pointing at $IP_ADDRESS"
}

upsert_record_set | tee -a $LOG_PATH
