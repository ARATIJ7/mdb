# instances.tf
resource "aws_instance" "mongodb_instance1" {
  provider                  = aws.region1
  ami                       = "ami-003932de22c285676"  # Replace with your AMI ID
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_security_group_ids    = [aws_security_group.mongodb_sg1.id]
  subnet_id                 = aws_subnet.subnet1.id
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y mongodb
              sudo sed -i 's/^  bindIp: .*$/  bindIp: 0.0.0.0/' /etc/mongod.conf
              sudo bash -c 'echo "replication:\n  replSetName: ${var.replica_set_name}" >> /etc/mongod.conf'
              sudo systemctl restart mongod
              sudo systemctl enable mongod

              # Wait for MongoDB to start
              sleep 30

              # Initiate the replica set
              mongo --eval 'rs.initiate({
                _id: "${var.replica_set_name}",
                members: [
                  { _id: 0, host: "${aws_instance.mongodb_instance1.public_ip}:27017" }
                ]
              })'
              EOF

  tags = {
    Name = "MongoDB-Instance-1"
  }
}

resource "aws_instance" "mongodb_instance2" {
  provider                  = aws.region2
  ami                       = "ami-0075013580f6322a1"  # Replace with your AMI ID
  instance_type             = var.instance_type
  key_name                  = var.key_name
  vpc_security_group_ids    = [aws_security_group.mongodb_sg2.id]
  subnet_id                 = aws_subnet.subnet2.id
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y mongodb
              sudo sed -i 's/^  bindIp: .*$/  bindIp: 0.0.0.0/' /etc/mongod.conf
              sudo bash -c 'echo "replication:\n  replSetName: ${var.replica_set_name}" >> /etc/mongod.conf'
              sudo systemctl restart mongod
              sudo systemctl enable mongod

              # Wait for MongoDB to start
              sleep 30

              # Wait for the primary to be ready
              until mongo --host ${aws_instance.mongodb_instance1.public_ip}:27017 --eval 'rs.status()'; do
                sleep 5
              done

              # Add the secondary to the replica set
              mongo --host ${aws_instance.mongodb_instance1.public_ip}:27017 --eval 'rs.add("${aws_instance.mongodb_instance2.public_ip}:27017")'
              EOF

  tags = {
    Name = "MongoDB-Instance-2"
  }
}
