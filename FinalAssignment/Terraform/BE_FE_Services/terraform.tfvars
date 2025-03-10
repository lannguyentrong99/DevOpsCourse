region = "us-west-2"
subnet_ids = [
  "subnet-0368d0be036d1bf0e",
  "subnet-04cd542711ebb6eba",
]
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
ECS_TaskExecutionRole_ARN = "arn:aws:iam::556705842113:role/FA_ECSTaskExecutionRole"

// Backend service params
backend_security_group_id = "sg-0748208db66c82bf8"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group-blue/17ad0d6cb61e619a"
backend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"

// Frontend service params
frontend_security_group_id = "sg-0094a6fe0e06edcf1"
FrontEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/front-end-target-group-blue/5d23133c86c27e73"
frontend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"