region = "us-west-2"
subnet_ids = [
  "subnet-0218e00ffef4ab7dc",
  "subnet-065b47dfac8ebb0d4",
]
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
ECS_TaskExecutionRole_ARN = "arn:aws:iam::556705842113:role/FA_ECSTaskExecutionRole"

// Backend service params
backend_security_group_id = "sg-0c9efddb3274cf972"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group-blue/82a8e0f208d43c2c"
backend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"

// Frontend service params
frontend_security_group_id = "sg-0a94989da7baf13d8"
FrontEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/front-end-target-group-blue/4beec69eeb3e6a39"
frontend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"