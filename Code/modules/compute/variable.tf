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

variable "backend_security_group_id" {
  type = string
  description = "backend_security_group_id"
  nullable = false
}

variable "FrontEnd_TargetGroup_ARN" {
  type = string
  description = "FrontEnd_TargetGroup_ARN"
  nullable = false
}

variable "BackEnd_TargetGroup_ARN" {
  type = string
  description = "BackEnd_TargetGroup_ARN"
  nullable = false
}