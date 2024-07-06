#!/bin/bash

# MongoDB instances' public IPs (replace with actual IPs if known)
PRIMARY_IP="PRIMARY_INSTANCE_PUBLIC_IP"
SECONDARY_IP="SECONDARY_INSTANCE_PUBLIC_IP"

# Connect to the primary instance and initiate the replica set
ssh -o StrictHostKeyChecking=no -i <path-to-key.pem> ubuntu@$PRIMARY_IP <<EOF
mongo --eval 'rs.initiate()'
EOF

# Add the secondary instance to the replica set
ssh -o StrictHostKeyChecking=no -i <path-to-key.pem> ubuntu@$PRIMARY_IP <<EOF
mongo --eval 'rs.add("$SECONDARY_IP:27017")'
EOF
