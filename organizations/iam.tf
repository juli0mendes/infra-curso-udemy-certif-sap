resource "aws_iam_group" "admin_group" {
  name = "admin"
}

resource "aws_iam_group_policy_attachment" "admin_group_attachment" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "julio_user" {
  name          = "julio"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "julio_user_login" {
  user                    = aws_iam_user.julio_user.name
  password_reset_required = true
}

resource "aws_iam_user_group_membership" "user_group_membership" {
  user = aws_iam_user.julio_user.name

  groups = [
    aws_iam_group.admin_group.name
  ]
}