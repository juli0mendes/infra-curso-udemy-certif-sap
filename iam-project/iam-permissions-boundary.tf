resource "aws_iam_user" "julio2" {
  name = "julio2"
  tags = {
    department = "code"
  }
  permissions_boundary = aws_iam_policy.iam_access.arn
}

resource "aws_iam_user_login_profile" "julio2_login_profile" {
  user                    = aws_iam_user.julio2.name
  password_reset_required = true
}

output "julio2_password" {
  value     = aws_iam_user_login_profile.julio2_login_profile.password
  sensitive = true
}
// para visualizar a senha gerada: terraform output -json julio2_password

data "aws_iam_policy_document" "full_iam_access" {
  statement {
    sid = "FullIAMAccess"

    effect = "Allow"

    actions = [
      "iam:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_iam_policy" "full_iam_access" {
  name        = "FullIAMAccess"
  path        = "/"
  description = "Policy to provide full access to IAM"
  policy      = data.aws_iam_policy_document.full_iam_access.json
}

resource "aws_iam_user_policy_attachment" "julio2_full_iam_access" {
  user       = aws_iam_user.julio2.name
  policy_arn = aws_iam_policy.full_iam_access.arn
}

data "aws_iam_policy_document" "iam_policy_document" {
  statement {
    sid = "IAMAccess"

    effect = "Allow"

    actions = [
      "iam:*"
    ]

    resources = [
      "*"
    ]
  }

  statement {
    sid = "DenyPermBoundaryIAMPolicyAlteration"

    effect = "Deny"

    actions = [
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:CreatePolicyVersion",
      "iam:SetDefaultPolicyVersion"
    ]

    resources = [
      "arn:aws:iam::351302643189:policy/AI-PermissionsBoundary"
    ]
  }

  statement {
    sid = "DenyRemovalOfPermBoundaryFromAnyUserOrRole"

    effect = "Deny"

    actions = [
      "iam:DeleteUserPermissionsBoundary",
      "iam:DeleteRolePermissionsBoundary"
    ]

    resources = [
      "arn:aws:iam::351302643189:user/*",
      "arn:aws:iam::351302643189:role/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        "arn:aws:iam::351302643189:policy/AI-PermissionsBoundary"
      ]
    }
  }

  statement {
    sid = "DenyAccessIfRequiredPermBoundaryIsNotBeingApplied"

    effect = "Deny"

    actions = [
      "iam:PutUserPermissionsBoundary",
      "iam:PutRolePermissionsBoundary"
    ]

    resources = [
      "arn:aws:iam::351302643189:user/*",
      "arn:aws:iam::351302643189:role/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "iam:PermissionsBoundary"
      values = [
        "arn:aws:iam::351302643189:policy/AI-PermissionsBoundary"
      ]
    }
  }

  statement {
    sid = "DenyUserAndRoleCreationWithOutPermBoundary"

    effect = "Deny"

    actions = [
      "iam:CreateUser",
                "iam:CreateRole"
    ]

    resources = [
      "arn:aws:iam::351302643189:user/*",
      "arn:aws:iam::351302643189:role/*"
    ]

    condition {
      test     = "StringNotEqualsIfExists"
      variable = "iam:PermissionsBoundary"
      values = [
        "arn:aws:iam::351302643189:policy/AI-PermissionsBoundary"
      ]
    }
  }
}

resource "aws_iam_policy" "iam_access" {
  name        = "AI-PermissionsBoundary"
  path        = "/"
  description = "Policy to provide IAM access"
  policy      = data.aws_iam_policy_document.iam_policy_document.json
}