terraform {
  backend "s3" {
    bucket         = "juli0mendes-terraform-state-file"
    key            = "terraform/state/infra-curso-udemy-certif-sap/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
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

module "remote_backend" {
  source = "./remote-backend"
}