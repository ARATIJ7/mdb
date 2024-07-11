#!/bin/bash
#cloud-config
runcmd:
  - |
    sudo apt-get update
    sudo apt-get install -y mongodb
    sudo systemctl start mongodb
    sleep 30
    mongo --eval 'rs.initiate({_id: "replicaSetName", members: [{ _id: 0, host: "${aws_instance.mongodb_instance1.public_ip}:27017" }]})'
