resource "aws_directory_service_directory" "microsoft_ad" {
  name     = "juli0mendes.private"
  password = "Qwerty24*"
  size     = "Small"
  type     = "MicrosoftAD"
  edition  = "Standard"

  vpc_settings {
    vpc_id = "vpc-828109ff"
    subnet_ids = [
      "subnet-17d7db5a",
      "subnet-45334a1a"
    ]
  }

  tags = {
    Name        = "example-directory"
    Environment = "Production"
  }
}

// Criar instancia EC2 para testar a conexão com o diretório
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
