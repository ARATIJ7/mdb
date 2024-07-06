# vpc.tf
resource "aws_vpc" "vpc1" {
  provider = aws.region1
  cidr_block = "10.0.0.0/16"
}

resource "aws_vpc" "vpc2" {
  provider = aws.region2
  cidr_block = "10.1.0.0/16"
}

resource "aws_subnet" "subnet1" {
  provider = aws.region1
  vpc_id = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region_1}a"
}

resource "aws_subnet" "subnet2" {
  provider = aws.region2
  vpc_id = aws_vpc.vpc2.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "${var.aws_region_2}a"
}
