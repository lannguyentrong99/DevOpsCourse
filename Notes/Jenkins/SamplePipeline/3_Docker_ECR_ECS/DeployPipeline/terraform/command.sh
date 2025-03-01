#Require: re-use keypair from terraform section.

#Commands Terraform:
cd singapore-dev
#Chỉnh sửa file sau: singapore-dev/terraform.tfvars
#Dòng 8: ecr_repo_url ->chỉnh sửa thành url ECR repository của bạn ví dụ:
556705842113.dkr.ecr.us-west-2.amazonaws.com/nodejs-random-color:latest

terraform init
terraform plan --var-file "terraform.tfvars"
terraform apply --var-file "terraform.tfvars"
terraform destroy --var-file "terraform.tfvars"
