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

resource "aws_iam_group_policy_attachment" "so_s3_access" {
  group      = aws_iam_group.groups["so"].name
  policy_arn = aws_iam_policy.s3_access.arn
}

resource "aws_iam_user" "julio1" {
  name = "julio1"
  tags = {
    department = "code"
  }
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
// para visualizar a senha gerada: terraform output -json julio1_password

data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    sid = "1"

    actions = [
      "s3:*"
    ]

    resources = [
      "arn:aws:s3:::*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalTag/department"
      values = [
        "code"
      ]
    }
  }
}

resource "aws_iam_policy" "s3_access" {
  name        = "s3-access"
  path        = "/"
  description = "Policy to provide S3 access"
  policy      = data.aws_iam_policy_document.s3_access_policy.json
}