#!/bin/bash

echo "Installing Least Privilege SDN Policy..."

ONOS_URL="${ONOS_URL:-http://localhost:8181}"
ONOS_USER="${ONOS_USER:-onos}"
: "${ONOS_PASS:?Set ONOS_PASS before running this script}"
ONOS="$ONOS_URL/onos/v1/flows/of:0000000000000001"
AUTH=(-u "$ONOS_USER:$ONOS_PASS")

# Block traffic from h1 (10.0.0.1) to h3 (10.0.0.3)
curl "${AUTH[@]}" -X POST -H "Content-Type: application/json" $ONOS -d '{
  "priority":50000,
  "isPermanent":true,
  "deviceId":"of:0000000000000001",
  "treatment":{
    "instructions":[]
  },
  "selector":{
    "criteria":[
      {
        "type":"ETH_TYPE",
        "ethType":"0x0800"
      },
      {
        "type":"IPV4_SRC",
        "ip":"10.0.0.1/32"
      },
      {
        "type":"IPV4_DST",
        "ip":"10.0.0.3/32"
      }
    ]
  }
}'

# Block traffic from h3 (10.0.0.3) to h1 (10.0.0.1)
curl "${AUTH[@]}" -X POST -H "Content-Type: application/json" $ONOS -d '{
  "priority":50000,
  "isPermanent":true,
  "deviceId":"of:0000000000000001",
  "treatment":{
    "instructions":[]
  },
  "selector":{
    "criteria":[
      {
        "type":"ETH_TYPE",
        "ethType":"0x0800"
      },
      {
        "type":"IPV4_SRC",
        "ip":"10.0.0.3/32"
      },
      {
        "type":"IPV4_DST",
        "ip":"10.0.0.1/32"
      }
    ]
  }
}'

echo ""
echo "Least Privilege Policy Installed!"
