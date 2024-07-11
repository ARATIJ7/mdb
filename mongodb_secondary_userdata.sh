#!/bin/bash
#cloud-config
runcmd:
  - |
    sudo apt-get update
    sudo apt-get install -y mongodb
    sudo systemctl start mongodb
    sleep 30
    PRIMARY_INSTANCE_IP="${aws_instance.mongodb_instance1.public_ip}"
    mongo --eval 'rs.add("${aws_instance.mongodb_instance2.public_ip}:27017")'
