# variables.tf
variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
  nullable = false
}

variable "alb_security_group_id" {
  type = string
  description = "alb_security_group_id"
  nullable = false
}