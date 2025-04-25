resource "aws_instance" "example" {
  ami           = "ami-0c765d44cf1f25d26"
  instance_type = "t2.micro"
  subnet_id     = "subnet-17d7db5a"
  key_name      = "juli0mendes"
  security_groups = [
    "sg-0b1b3b7b1b1b1b1b1"
  ]

  tags = {
    Name = "Server1"
  }
}