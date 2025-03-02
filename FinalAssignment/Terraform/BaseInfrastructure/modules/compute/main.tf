provider "aws" {
  region = var.region
}

resource "aws_ecs_cluster" "FA_ECS_Cluster" {
  name = "FA-ECS-Cluster"
}