variable "region" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
}

variable "frontend_security_group_id" {
  type = string
  description = "frontend_security_group_id"
  nullable = false
}

variable "FrontEnd_TargetGroup_ARN" {
  type = string
  description = "FrontEnd_TargetGroup_ARN"
  nullable = false
}

variable "aws_ecs_cluster_id" {
  type = string
  description = "FA_ECS_Cluster id"
  nullable = false
}

variable "image_uri" {
  type = string
  description = "Image URI"
  nullable = false
}