resource "aws_vpc" "vpc_a" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  assign_generated_ipv6_cidr_block = true

  tags = {
    "Name" = "vpc-a"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                          = aws_vpc.vpc_a.id
  cidr_block                      = "10.0.16.0/20"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.vpc_a.ipv6_cidr_block, 8, 0)
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = true
  availability_zone               = "us-east-1b"

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