output "password" {
  value = aws_iam_user_login_profile.julio_user_login.password
  sensitive = true
}

output "organization_id" {
  value = aws_organizations_organization.organization.id
  description = "ID da organização criada"
}