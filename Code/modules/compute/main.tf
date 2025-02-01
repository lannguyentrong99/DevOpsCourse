resource "aws_ecs_cluster" "FA_ECS_Cluster" {
  name = "FA-ECS-Cluster"
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
      image      = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"
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

resource "aws_ecs_task_definition" "FA_BackEnd_TaskDefinition" {
  family                   = "FA_BackEnd_TaskDefinition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu        = 256
  memory     = 512
  execution_role_arn = "arn:aws:iam::556705842113:role/ecsTaskExecutionRole"

  container_definitions   = jsonencode([
    {
      name       = "BackEndContainer"
      image      = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"
      essential  = true
      portMappings = [
        {
          containerPort = 8080
          hostPort      = 8080
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "FA_FrontEnd_ECS_Service" {
  name            = "FA_FrontEnd_ECS_Service"
  cluster         = aws_ecs_cluster.FA_ECS_Cluster.id
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

resource "aws_ecs_service" "FA_BackEnd_ECS_Service" {
  name            = "FA_BackEnd_ECS_Service"
  cluster         = aws_ecs_cluster.FA_ECS_Cluster.id
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
}