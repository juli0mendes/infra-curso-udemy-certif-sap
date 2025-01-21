provider "aws" {
  region = "us-east-1"
}

module "name" {
  source = "./organizations"  
}