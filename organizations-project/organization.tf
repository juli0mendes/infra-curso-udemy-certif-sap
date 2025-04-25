resource "aws_organizations_organization" "organization" {
  feature_set = "ALL"
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY"
  ]
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

  tags = {
    Environment = "SysOps"
    Project     = "AWS Organization Automation"
  }
}

resource "aws_organizations_organizational_unit" "rio_de_janeiro_ou" {
  name      = "Rio de Janeiro"
  parent_id = aws_organizations_organization.organization.roots[0].id
}

resource "aws_organizations_policy" "deny_s3_remove_bucket_policy" {
  name        = "DenyS3RemoveBucket"
  description = "Deny S3 Remove Bucket Policy"
  content     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyS3RemoveBucket",
      "Effect": "Deny",
      "Action": "s3:DeleteBucket",
      "Resource": "*"
    }
  ]
}
EOF
  type = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy_attachment" "sysop_deny_s3_remove_bucket_policy" {
  policy_id = aws_organizations_policy.deny_s3_remove_bucket_policy.id
  target_id = aws_organizations_account.sysop_account.id
}