region = "us-west-2"
subnet_ids = [
  "subnet-0a9340d56ac18c27f",
  "subnet-02f0a41231d878000",
]
frontend_security_group_id = "sg-02b325c179fcbe58b"
FrontEnd_TargetGroup_ARN = "arn:aws:elasticloadbalancing:us-west-2:556705842113:targetgroup/front-end-target-group/27126532565357a9"
aws_ecs_cluster_id = "arn:aws:ecs:us-west-2:556705842113:cluster/FA-ECS-Cluster"
image_uri = "556705842113.dkr.ecr.us-west-2.amazonaws.com/fa_front_end:latest"