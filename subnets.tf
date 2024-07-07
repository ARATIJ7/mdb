resource "aws_subnet" "subnet1" {
  provider           = aws.region1
  vpc_id             = aws_vpc.vpc1.id
  cidr_block         = "10.0.1.0/24"
  availability_zone  = "us-west-2a"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  provider           = aws.region2
  vpc_id             = aws_vpc.vpc2.id
  cidr_block         = "10.1.1.0/24"
  availability_zone  = "us-east-1a"

  tags = {
    Name = "subnet2"
  }
}

resource "aws_route_table_association" "assoc1" {
  provider       = aws.region1
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.public_rt1.id
}

resource "aws_route_table_association" "assoc2" {
  provider       = aws.region2
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public_rt2.id
}
