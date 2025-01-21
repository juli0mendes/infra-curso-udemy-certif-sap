resource "aws_organizations_organization" "organization" {
  feature_set = "ALL"
}

resource "aws_organizations_account" "dev_account" {
  name      = "dev-juli0mendes"
  email     = "juuliomendes2@gmail.com"
  role_name = "OrganizationAccountAccessRole"
  parent_id = aws_organizations_organizational_unit.rio_de_janeiro_ou.id

  tags = {
    Environment = "Development"
    Project     = "AWS Organization Automation"
  }
}

resource "aws_organizations_account" "prod_account" {
  name      = "prod-juli0mendes"
  email     = "juuliomendesitau@gmail.com"
  role_name = "OrganizationAccountAccessRole"
  parent_id = aws_organizations_organizational_unit.rio_de_janeiro_ou.id

  tags = {
    Environment = "Production"
    Project     = "AWS Organization Automation"
  }
}

resource "aws_organizations_account" "sysop_account" {
  name      = "sysop-juli0mendes"
  email     = "juuliomendes3@gmail.com"
  role_name = "OrganizationAccountAccessRole"
  parent_id = aws_organizations_organizational_unit.rio_de_janeiro_ou.id

  tags = {
    Environment = "SysOps"
    Project     = "AWS Organization Automation"
  }
}

resource "aws_organizations_organizational_unit" "rio_de_janeiro_ou" {
  name      = "Rio de Janeiro"
  parent_id = aws_organizations_organization.organization.roots[0].id
}