provider "aws" {
  region = var.region
}


resource "aws_ecs_task_definition" "FA_FrontEnd_TaskDefinition" {
  family                   = "FA_FrontEnd_TaskDefinition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu        = 256
  memory     = 512
  execution_role_arn = "arn:aws:iam::556705842113:role/ecsTaskExecutionRole"

  container_definitions   = jsonencode([
    {
      name       = "FrontEndContainer"
      image      = var.image_uri
      essential  = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "FA_FrontEnd_ECS_Service" {
  name            = "FA_FrontEnd_ECS_Service"
  cluster         = var.aws_ecs_cluster_id
  task_definition = aws_ecs_task_definition.FA_FrontEnd_TaskDefinition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.frontend_security_group_id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.FrontEnd_TargetGroup_ARN
    container_name   = "FrontEndContainer"
    container_port   = 3000
  }
}