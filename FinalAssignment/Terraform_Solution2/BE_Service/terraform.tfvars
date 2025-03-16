region = "us-west-2"
subnet_ids = [
  "subnet-03b40c28500ba913a",
  "subnet-053f8b0fb2c709b43",
]
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
ECS_TaskExecutionRole_ARN = "arn:aws:iam::556705842113:role/FA_ECSTaskExecutionRole"

// Backend service params
backend_security_group_id = "sg-09fa6223fd5edb5af"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group-blue/e338e65cc7f38f4c"
backend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"

// CloudFront
origin_id = "fa-static-website-bucket"