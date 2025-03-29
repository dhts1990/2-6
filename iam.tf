data "aws_caller_identity" "current" {}

resource "aws_iam_policy" "huang_dynamodb_read_policy" {
  name        = "huang-dynamodb-read-policy"
  description = "Policy to allow all read and list operations on DynamoDB table glenn-bookinventory"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "dynamodb:DescribeTable",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:GetItem"
        ]
        Resource = "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/huang-tf-2-6-bookinventory"
      },
      {
        Effect = "Allow",
        Action = [
          "dynamodb:ListTables"
        ],
        Resource = "arn:aws:dynamodb:us-east-1:${data.aws_caller_identity.current.account_id}:table/*"
      }
    ]
  })
}

resource "aws_iam_role" "huang_dynamodb_read_role" {
  name               = "huang-dynamodb-read-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "huang_dynamodb_read_role_attachment" {
  role       = aws_iam_role.huang_dynamodb_read_role.name
  policy_arn = aws_iam_policy.huang_dynamodb_read_policy.arn
}

resource "aws_iam_instance_profile" "test_profile" {
  name = "huang_instance_profile"
  role = aws_iam_role.huang_dynamodb_read_role.name
}