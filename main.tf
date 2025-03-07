provider "aws" {
  region = "us-east-1"
}

module "iam_project" {
  source = "./iam-project"
}

module "organizations_project" {
  source = "./organizations-project"
}

resource "null_resource" "example" {
  count = var.run_terraform_apply ? 1 : 0
  provisioner "local-exec" {
    command = "echo Run Terraform Apply: ${var.run_terraform_apply}"
  }
}