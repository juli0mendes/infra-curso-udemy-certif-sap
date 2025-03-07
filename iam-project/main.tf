locals {
  groups = ["so", "group2", "group3"]
}

resource "aws_iam_group" "groups" {
  for_each = toset(local.groups)
  name     = each.value
}

resource "aws_iam_group_policy_attachment" "so_support_user" {
  group      = aws_iam_group.groups["so"].name
  policy_arn = "arn:aws:iam::aws:policy/AWSSupportAccess"
}

resource "aws_iam_user" "julio1" {
  name = "julio1"
}

resource "aws_iam_user_group_membership" "julio1_membership" {
  user   = aws_iam_user.julio1.name
  groups = [aws_iam_group.groups["so"].name]
}

resource "aws_iam_user_login_profile" "julio1_login_profile" {
  user                    = aws_iam_user.julio1.name
  password_reset_required = true
}

output "julio1_password" {
  value     = aws_iam_user_login_profile.julio1_login_profile.password
  sensitive = true
}
