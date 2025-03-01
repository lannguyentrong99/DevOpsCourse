output "subnet_ids" {
  value = module.networking.public_subnet_ids
}
output "backend_security_group_id" {
  value = module.security.BackEnd_SecurityGroupID
}
output "frontend_security_group_id" {
  value = module.security.FrontEnd_SecurityGroupID
}
output "database_security_group_id" {
  value = module.security.Database_SecurityGroupID
}
output "BackEnd_TargetGroup_ARN" {
  value = module.load_balancing.BackEnd_TargetGroup_ARN
}
output "FrontEnd_TargetGroup_ARN" {
  value = module.load_balancing.FrontEnd_TargetGroup_ARN
}
output "aws_ecs_cluster_id" {
  value = module.compute.aws_ecs_cluster_id
}
output "alb_dns_name" {
  value = module.load_balancing.alb_dns_name
}