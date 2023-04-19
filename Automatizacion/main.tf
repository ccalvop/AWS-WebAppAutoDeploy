resource "aws_iam_user" "webapp_auto_deploy_user" {
  name = "WebAppAutoDeployUser"
}

resource "aws_iam_user_policy" "webapp_auto_deploy_policy" {
  name = "WebAppAutoDeployPolicy"
  user = aws_iam_user.webapp_auto_deploy_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "codebuild:*"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "codepipeline:*"
        ]
        Resource = "*"
      }
    ]
  })
}