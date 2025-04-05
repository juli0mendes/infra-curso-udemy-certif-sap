provider "aws" {
  region = "us-east-1"
}

variable "infra_create" {
  default = true # Altere para false se quiser executar o destroy
}

# module "iam_project" {
#   source = "./iam-project"
# }

# module "organizations_project" {
#   source = "./organizations-project"
# }

# module "directory_service" {
#   source = "./directory-service"
# }

module "vpc" {
  source = "./vpc"
}