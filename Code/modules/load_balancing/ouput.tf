output "FrontEnd_TargetGroup_ARN" {
  value = aws_lb_target_group.FA_FrontEnd_TargetGroup.arn
}
output "BackEnd_TargetGroup_ARN" {
  value = aws_lb_target_group.FA_BackEnd_TargetGroup.arn
}