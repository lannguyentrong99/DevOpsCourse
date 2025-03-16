provider "aws" {
  region = var.region
}

resource "aws_cloudwatch_log_group" "FA_BackEnd_log_group" {
  name = "ecs/FA_BackEnd_log_group"
  retention_in_days = 1
}

resource "aws_ecs_task_definition" "FA_BackEnd_TaskDefinition" {
  family                   = "FA_BackEnd_TaskDefinition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu        = 256
  memory     = 512
  execution_role_arn = var.ECS_TaskExecutionRole_ARN

  container_definitions   = jsonencode([
    {
      name       = "BackEndContainer"
      image      = var.backend_image_uri
      essential  = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ],
      logConfiguration: {
        logDriver: "awslogs",
        options: {
          awslogs-group         = aws_cloudwatch_log_group.FA_BackEnd_log_group.name,
          awslogs-region        = var.region,
          awslogs-stream-prefix = "backend-container"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "FA_BackEnd_ECS_Service" {
  name            = "FA_BackEnd_ECS_Service"
  cluster         = var.aws_ecs_cluster_id
  task_definition = aws_ecs_task_definition.FA_BackEnd_TaskDefinition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.backend_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.BackEnd_TargetGroup_ARN
    container_name   = "BackEndContainer"
    container_port   = 8080
  }
  deployment_controller {
    type = "CODE_DEPLOY"
  }
}

// FrontEnd
resource "aws_s3_bucket" "static_website_bucket" {
  bucket = "fa-static-website-bucket"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.static_website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  bucket = aws_s3_bucket.static_website_bucket.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.static_website_bucket.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "Statement2",
        "Principal": "*",
        "Effect": "Allow",
        "Action": [
          "s3:GetObject"
        ],
        "Resource": [
          "${aws_s3_bucket.static_website_bucket.arn}/*"
        ]
      }
    ]
  })
}


// CloudFront
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
    origin_id                = var.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only" # Use HTTP only
      origin_ssl_protocols   = ["TLSv1.2"] # Required by Terraform, but won't be used with "http-only"
    }
  }

  enabled             = true
  default_root_object = "index.html"
  is_ipv6_enabled     = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations = []
    }
  }

  tags = {
    Environment = "fa-test"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}