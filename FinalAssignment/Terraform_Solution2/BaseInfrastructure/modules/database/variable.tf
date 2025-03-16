variable "region" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
  nullable = false
}
variable "vpc_security_group_ids" {
  type = list(string)
  nullable = false
}