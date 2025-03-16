output "subnet_ids" {
  value = module.networking.public_subnet_ids
}
output "backend_security_group_id" {
  value = module.security.BackEnd_SecurityGroupID
}
output "BackEnd_TargetGroup_ARN" {
  value = module.load_balancing.BackEnd_TargetGroup_ARN
}
output "aws_ecs_cluster_id" {
  value = module.compute.aws_ecs_cluster_id
}
output "alb_dns_name" {
  value = module.load_balancing.alb_dns_name
}
output "cluster_endpoint" {
  value = module.database.cluster_endpoint
}
output "ECS_TaskExecutionRole_ARN" {
  value = module.security.ECS_TaskExecutionRole_ARN
}