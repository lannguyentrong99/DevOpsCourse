region = "us-west-2"
subnet_ids = [
  "subnet-079c32c2f51be42a0",
  "subnet-079c32c2f51be42a0",
  "subnet-067c4bea889d737cb",
]
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"

// Backend service params
backend_security_group_id = "sg-0c30b37c2c86b42e2"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group/cecb26ff55536657"
backend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"

// Frontend service params
frontend_security_group_id = "sg-0f3b49349ed332d85"
FrontEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/front-end-target-group/e0640adacdfc89b2"
frontend_image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"