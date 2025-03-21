provider "aws" {
  region = var.region
}

#Create a complete VPC using module networking
module "networking" {
  source = "./modules/networking"
  region = var.region
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  cidr_block = var.cidr_block
  public_subnet_ips = var.public_subnet_ips
}

module "security" {
  source = "./modules/security"
  region = var.region
  vpc_id = module.networking.vpc_id
}

module "load_balancing" {
  source = "./modules/load_balancing"
  vpc_id = module.networking.vpc_id
  region = var.region
  subnet_ids = module.networking.public_subnet_ids
  alb_security_group_id = module.security.ALB_SecurityGroupID
}

module "compute" {
  source = "./modules/compute"
  region = var.region
}

module "database" {
  source = "./modules/database"
  region = var.region
  subnet_ids = module.networking.public_subnet_ids
  vpc_security_group_ids = [module.security.Database_SecurityGroupID]
}