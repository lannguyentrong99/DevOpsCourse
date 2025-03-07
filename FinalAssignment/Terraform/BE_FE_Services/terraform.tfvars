region = "us-west-2"
subnet_ids = [
  "subnet-06e1a6d058b95a2f3",
  "subnet-0030795a031f3ffbe",
]
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
ECS_TaskExecutionRole_ARN = "arn:aws:iam::556705842113:role/FA_ECSTaskExecutionRole"

// Backend service params
backend_security_group_id = "sg-044cfede2ae1b6615"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group-blue/ff887d9bd9f83758"
backend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"

// Frontend service params
frontend_security_group_id = "sg-07ad29f2329f8c61d"
FrontEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/front-end-target-group-blue/d657be4463a7c90b"
frontend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"