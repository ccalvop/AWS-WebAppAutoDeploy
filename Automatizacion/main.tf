resource "aws_iam_user" "webapp_auto_deploy_user" {
  name = "WebAppAutoDeployUser"
}

resource "aws_iam_policy" "webapp_auto_deploy_policy" {
  name        = "WebAppAutoDeployPolicy"
  description = "Policy for WebAppAutoDeploy user"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = "s3:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "codebuild:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "codepipeline:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = "codestar-connections:*"
        Resource = "*"
      },
      {
        Effect   = "Allow"
        Action   = [
          "iam:CreateRole",
          "iam:AttachRolePolicy",
          "iam:PutRolePolicy",
          "iam:PassRole",
        ]
        Resource = "arn:aws:iam::*:role/service-role/*"
      },
      {
        Effect   = "Allow"
        Action   = "iam:CreatePolicy"
        Resource = "arn:aws:iam::*:policy/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "webapp_auto_deploy_user_policy_attachment" {
  user       = aws_iam_user.webapp_auto_deploy_user.name
  policy_arn = aws_iam_policy.webapp_auto_deploy_policy.arn
}
