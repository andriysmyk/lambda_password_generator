terraform {
  backend "s3" {
    bucket = "terraform-state-asmyk"
    key    = "lambda/terraform.tfstate"
    region = "eu-west-2"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region     = "eu-west-2"
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name        = "LambdaCloudWatchAccessPolicy"
  description = "IAM policy for Lambda to access CloudWatch logs and metrics"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:GetLogEvents",
          "logs:DescribeLogStreams",
          "cloudwatch:GetMetricData",
          "cloudwatch:GetMetricStatistics",
          "cloudwatch:ListMetrics"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "example" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_policy_attachment" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
}

resource "aws_lambda_function" "example" {
  s3_bucket     = "lambda-code-asmyk"
  s3_key        = "lambda.zip"
  function_name = "password_generator_tf"
  role          = aws_iam_role.example.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = var.lambda_runtime

  tags = {
    Environment = var.env
  }
}
