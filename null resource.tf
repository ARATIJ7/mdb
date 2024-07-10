resource "null_resource" "configure_mongodb_replica_set" {
  provisioner "local-exec" {
    command = <<-EOT
              #!/bin/bash
              PRIMARY_IP=${aws_instance.mongodb_instance1.public_ip}
              SECONDARY_IP=${aws_instance.mongodb_instance2.public_ip}

              # Initiate the replica set on the primary instance
              ssh -o StrictHostKeyChecking=no -i ${var.key_name}.pem ubuntu@$PRIMARY_IP <<EOF
              mongo --eval 'rs.initiate({
                _id: "${var.replica_set_name}",
                members: [
                  { _id: 0, host: "$PRIMARY_IP:27017" }
                ]
              })'
              EOF

              # Wait for the primary to be ready
              sleep 60

              # Add the secondary to the replica set
              ssh -o StrictHostKeyChecking=no -i ${var.key_name}.pem ubuntu@$PRIMARY_IP <<EOF
              mongo --eval 'rs.add("$SECONDARY_IP:27017")'
              EOF
              EOT
  }

  depends_on = [aws_instance.mongodb_instance1, aws_instance.mongodb_instance2]
}
