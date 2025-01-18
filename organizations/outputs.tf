output "password" {
  value = aws_iam_user_login_profile.julio_user_login.password
  sensitive = true
}

output "organization_id" {
  value = aws_organizations_organization.organization.id
  description = "ID da organização criada"
}

output "dev_account_id" {
  value       = aws_organizations_account.dev_account.id
  description = "ID da conta AWS de DEV criada"
}

output "prod_account_id" {
  value       = aws_organizations_account.prod_account.id
  description = "ID da conta AWS de PROD criada"
}