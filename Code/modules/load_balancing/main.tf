provider "aws" {
  region = var.region
}

# Application Load Balancer
resource "aws_lb" "FA_ALB" {
  name               = "final-assignment-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "FA_FrontEnd_TargetGroup" {
  name     = "front-end-target-group"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_target_group" "FA_BackEnd_TargetGroup" {
  name     = "back-end-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"

  health_check {
    path                = "/api/students"
    interval            = 30
    timeout             = 15
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "FA_ALB_Listener" {
  load_balancer_arn = aws_lb.FA_ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_FrontEnd_TargetGroup.arn
  }
}

resource "aws_lb_listener_rule" "FA_BackEnd_Rule" {
  listener_arn = aws_lb_listener.FA_ALB_Listener.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_BackEnd_TargetGroup.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}