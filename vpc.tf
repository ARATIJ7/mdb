# vpc.tf
resource "aws_vpc" "vpc1" {
  provider = aws.region1
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "vpc2" {
  provider = aws.region2
  cidr_block = "10.1.0.0/16"
}

resource "aws_security_group" "mongodb_sg1" {
  provider = aws.region1
  vpc_id = aws_vpc.vpc1.id
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mongodb_sg2" {
  provider = aws.region2
  vpc_id = aws_vpc.vpc2.id
  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
