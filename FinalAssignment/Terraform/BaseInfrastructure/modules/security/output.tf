output "ALB_SecurityGroupID" {
  value = aws_security_group.ALB_SecurityGroup.id
}
output "FrontEnd_SecurityGroupID" {
  value = aws_security_group.FrontEnd_SecurityGroup.id
}
output "BackEnd_SecurityGroupID" {
  value = aws_security_group.BackEnd_SecurityGroup.id
}
output "Database_SecurityGroupID" {
  value = aws_security_group.Database_SecurityGroup.id
}
output "ECS_TaskExecutionRole_ARN" {
  value = aws_iam_role.FA_ECSTaskExecutionRole.arn
}