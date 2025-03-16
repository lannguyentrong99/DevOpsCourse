variable "region" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
}

variable "aws_ecs_cluster_id" {
  type = string
  description = "FA_ECS_Cluster id"
  nullable = false
}

// Backend service variables
variable "backend_security_group_id" {
  type = string
  description = "backend_security_group_id"
  nullable = false
}

variable "BackEnd_TargetGroup_ARN" {
  type = string
  description = "BackEnd_TargetGroup_ARN"
  nullable = false
}

variable "backend_image_uri" {
  type = string
  description = "Image URI"
  nullable = false
}

variable "ECS_TaskExecutionRole_ARN" {
  type = string
  description = "ECS_TaskExecutionRole_ARN"
  nullable = false
}

variable "origin_id" {
  type = string
}