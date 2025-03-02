region = "us-west-2"
subnet_ids = [
  "subnet-0a9340d56ac18c27f",
  "subnet-02f0a41231d878000",
]
backend_security_group_id = "sg-0f23c04946eccbc7e"
BackEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/back-end-target-group/62e05d998b8b39ff"
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_back_end:latest"