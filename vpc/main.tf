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

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_security_group" "webserver_sg" {
  name        = "webserver-access"
  description = "Allow SSH, HTTP, and HTTPS traffic"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "webserver-access"
  }
}

resource "aws_instance" "webserver" {
  depends_on = [aws_security_group.webserver_sg]

  ami                    = "ami-0e449927258d45bc4"
  instance_type          = "t2.micro"
  key_name               = "ec2-webserver"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  associate_public_ip_address = true

  tags = {
    "Name" = "webserver"
  }
}

resource "aws_security_group" "database_sg" {
  name        = "database-access"
  description = "Allow traffic from webserver_sg"
  vpc_id      = aws_vpc.vpc_a.id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.webserver_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "database-access"
  }
}

resource "aws_instance" "database" {
  depends_on = [aws_security_group.database_sg]

  ami                    = "ami-0e449927258d45bc4"
  instance_type          = "t2.micro"
  key_name               = "ec2-database"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.database_sg.id]

  associate_public_ip_address = false

  tags = {
    "Name" = "database"
  }
}
