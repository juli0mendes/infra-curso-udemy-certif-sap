provider "aws" {
  region = "us-east-1"
}

module "iam_project" {
  source = "./iam-project"
  count  = var.enable_iam_project ? 1 : 0
}

module "organizations_project" {
  source = "./organizations-project"
  count  = var.enable_organizations_project ? 1 : 0
}

# Use a variável run_terraform_apply em algum lugar para garantir que ela seja considerada
resource "null_resource" "example" {
  count = var.run_terraform_apply ? 1 : 0
  provisioner "local-exec" {
    command = "echo Run Terraform Apply: ${var.run_terraform_apply}"
  }
}
