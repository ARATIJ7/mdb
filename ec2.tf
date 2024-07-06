# ec2.tf
resource "aws_instance" "mongodb_instance1" {
  provider = aws.region1
  ami = "ami-0c55b159cbfafe1f0"  # Replace with your AMI ID
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.mongodb_sg1.name]
  subnet_id = aws_subnet.subnet1.id

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y mongodb
              sudo sed -i 's/^  bindIp: .*$/  bindIp: 0.0.0.0/' /etc/mongod.conf
              sudo systemctl restart mongod
              EOF

  tags = {
    Name = "MongoDB-Instance-1"
  }
}

resource "aws_instance" "mongodb_instance2" {
  provider = aws.region2
  ami = "ami-0c55b159cbfafe1f0"  # Replace with your AMI ID
  instance_type = var.instance_type
  key_name = var.key_name
  security_groups = [aws_security_group.mongodb_sg2.name]
  subnet_id = aws_subnet.subnet2.id

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y mongodb
              sudo sed -i 's/^  bindIp: .*$/  bindIp: 0.0.0.0/' /etc/mongod.conf
              sudo systemctl restart mongod
              EOF

  tags = {
    Name = "MongoDB-Instance-2"
  }
}
