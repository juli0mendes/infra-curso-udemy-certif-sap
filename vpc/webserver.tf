resource "aws_instance" "webserver" {
  count                  = 2
  ami                    = "ami-0e449927258d45bc4"
  instance_type          = "t2.micro"
  key_name               = "ec2-webserver"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.webserver_sg.id]

  associate_public_ip_address = true

  tags = {
    "Name" = "webserver-${count.index + 1}"
  }
}