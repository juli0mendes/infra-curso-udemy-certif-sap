provider "aws" {
  region = "us-east-1"
}

module "iam_project" {
  source = "./iam-project"
}

module "organizations_project" {
  source = "./organizations-project"
}