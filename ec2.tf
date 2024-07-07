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
              sudo systemctl restart mongod
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
              sudo systemctl restart mongod
              EOF

  tags = {
    Name = "MongoDB-Instance-2"
  }
}
