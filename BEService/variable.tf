variable "region" {
  type = string
}
variable "backend_security_group_id" {
  type = string
  description = "backend_security_group_id"
  nullable = false
}
variable "subnet_ids" {
  type = list(string)
  nullable = false
}
variable "BackEnd_TargetGroup_ARN" {
  type = string
  description = "BackEnd_TargetGroup_ARN"
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