# create iam policy document. this policy allows the ecs service to assume a role
data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# create iam policy document
data "aws_iam_policy_document" "ecs_task_execution_policy_document" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::<enter-s3-bucket-name>/*"
    ]
  }

  statement {
    actions    = [
      "s3:GetBucketLocation"
    ]

    resources = [
      "arn:aws:s3:::<enter-s3-bucket-name>"
    ]
  }
}

# create iam policy
resource "aws_iam_policy" "ecs_task_execution_policy" {
  name   = 
  policy = 
}

# create an iam role
resource "aws_iam_role" "ecs_task_execution_role" {
  name                = 
  assume_role_policy  = 
}

# attach ecs task execution policy to the iam role
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = 
  policy_arn = 
}