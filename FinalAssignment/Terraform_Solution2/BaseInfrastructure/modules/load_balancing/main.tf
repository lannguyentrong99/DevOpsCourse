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
// Blue target groups
resource "aws_lb_target_group" "FA_BackEnd_TargetGroup_blue" {
  name     = "back-end-target-group-blue"
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
// Blue listener
resource "aws_lb_listener" "FA_ALB_Listener_blue" {
  load_balancer_arn = aws_lb.FA_ALB.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_BackEnd_TargetGroup_blue.arn
  }
}

resource "aws_lb_listener_rule" "FA_BackEnd_Rule_blue" {
  listener_arn = aws_lb_listener.FA_ALB_Listener_blue.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_BackEnd_TargetGroup_blue.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

// Green target group
resource "aws_lb_target_group" "FA_BackEnd_TargetGroup_green" {
  name     = "back-end-target-group-green"
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


// Green listener
resource "aws_lb_listener" "FA_ALB_Listener_green" {
  load_balancer_arn = aws_lb.FA_ALB.arn
  port              = 81
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_BackEnd_TargetGroup_green.arn
  }
}

resource "aws_lb_listener_rule" "FA_BackEnd_Rule_green" {
  listener_arn = aws_lb_listener.FA_ALB_Listener_green.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.FA_BackEnd_TargetGroup_green.arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}