resource "aws_organizations_organization" "organization" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "dev_account" {
  name      = "dev-juli0mendes"
  email     = "juuliomendes2@gmail.com"
  role_name = "OrganizationAccountAccessRole"

  tags = {
    Environment = "Development"
    Project     = "AWS Organization Automation"
  }
}

resource "aws_organizations_account" "prod_account" {
  name      = "prod-juli0mendes"
  email     = "juuliomendesitau@gmail.com"
  role_name = "OrganizationAccountAccessRole"

  tags = {
    Environment = "Production"
    Project     = "AWS Organization Automation"
  }
}
