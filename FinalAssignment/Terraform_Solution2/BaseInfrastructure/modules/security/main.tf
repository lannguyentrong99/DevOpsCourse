provider "aws" {
  region = var.region
}

resource "aws_security_group" "ALB_SecurityGroup" {
  name        = "ALB_SecurityGroup"
  description = "ALB_SecurityGroup"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 81
    to_port     = 81
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "BackEnd_SecurityGroup" {
  name        = "BackEnd_SecurityGroup"
  description = "BackEnd_SecurityGroup"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.ALB_SecurityGroup.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Database_SecurityGroup" {
  name        = "Database_SecurityGroup"
  description = "Database_SecurityGroup"
  vpc_id = var.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.BackEnd_SecurityGroup.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


// ECS Task execution role
resource "aws_iam_role" "FA_ECSTaskExecutionRole" {
  name = "FA_ECSTaskExecutionRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_policy" "FA_ECSTaskExecutionPolicy" {
  name        = "FA_ECSTaskExecutionPolicy"
  description = "Policy for ECS task execution role"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:*"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "task_execution_policy_attachment" {
  role       = aws_iam_role.FA_ECSTaskExecutionRole.name
  policy_arn = aws_iam_policy.FA_ECSTaskExecutionPolicy.arn
}