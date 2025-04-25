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
