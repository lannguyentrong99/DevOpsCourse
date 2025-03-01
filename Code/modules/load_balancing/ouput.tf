output "FrontEnd_TargetGroup_ARN" {
  value = aws_lb_target_group.FA_FrontEnd_TargetGroup.arn
}
output "BackEnd_TargetGroup_ARN" {
  value = aws_lb_target_group.FA_BackEnd_TargetGroup.arn
}
output "alb_dns_name" {
  value = aws_lb.FA_ALB.dns_name
}