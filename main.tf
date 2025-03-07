provider "aws" {
  region = "us-east-1"
}

module "iam_project" {
  source = "./iam-project"
  count  = var.enable_iam_project ? 1 : 0
}

module "organizations_project" {
  source = "./organizations-project"
}
