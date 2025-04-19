resource "aws_vpc" "vpc_a" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    "Name" = "vpc-a"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc_a.id
  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    "Name" = "public-subnet-a"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc_a.id
  cidr_block        = "10.0.32.0/20"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-subnet-b"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    "Name" = "public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    "Name" = "private-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc_a.id

  tags = {
    "Name" = "igtw-vpc-a"
  }
}
