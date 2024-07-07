resource "aws_vpc" "vpc1" {
  provider             = aws.region1
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc1"
  }
}

resource "aws_vpc" "vpc2" {
  provider             = aws.region2
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc2"
  }
}

resource "aws_internet_gateway" "igw1" {
  provider = aws.region1
  vpc_id   = aws_vpc.vpc1.id

  tags = {
    Name = "igw1"
  }
}

resource "aws_internet_gateway" "igw2" {
  provider = aws.region2
  vpc_id   = aws_vpc.vpc2.id

  tags = {
    Name = "igw2"
  }
}

resource "aws_route_table" "public_rt1" {
  provider = aws.region1
  vpc_id   = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }

  tags = {
    Name = "public-rt1"
  }
}

resource "aws_route_table" "public_rt2" {
  provider = aws.region2
  vpc_id   = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }

  tags = {
    Name = "public-rt2"
  }
}
