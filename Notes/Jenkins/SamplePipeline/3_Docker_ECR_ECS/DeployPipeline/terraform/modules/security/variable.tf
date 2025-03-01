variable "region" {
  type = string
  default = "us-west-2"
}
variable "vpc_id" {
  type = string
  description = "The VPC ID"
  nullable = false
  
}