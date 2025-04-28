# Configure the Terraform provider block to use AWS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.94.1"
    }
  }
}

# Call the VPC module and pass in network configuration variables
module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  azs                  = var.azs
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

# Security module
module "security" {
  source            = "./modules/security"
  vpc_id            = module.vpc.vpc_id
  ssh_access_cidr   = var.ssh_access_cidr
}

module "ec2" {
  source                      = "./modules/ec2"
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  # Temporary: Using public subnet for EC2 to avoid NAT Gateway costs during development
  private_subnet_id = module.vpc.public_subnet_ids[0]
  
  # private_subnet_id = module.vpc.private_subnet_ids[0] # Use this line instead in production
  security_group_id           = module.security.ec2_sg_id
  key_name                    = var.key_name
  target_group_arn            = module.alb.target_group_arn

  db_name                     = var.db_name
  db_username                 = var.db_username
  db_password                 = var.db_password
  db_host                     = module.rds.rds_endpoint
}

# Bastion Host module
# module "bastion" {
#   source            = "./modules/bastion"
#   ami_id            = var.ami_id
#   instance_type     = var.bastion_instance_type
#   public_subnet_id  = module.vpc.public_subnet_ids[0]
#   security_group_id = module.security.bastion_sg_id
#   key_name          = var.key_name
# }

# Application Load Balancer module
module "alb" {
  source            = "./modules/alb"
  public_subnet_ids = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  alb_sg_id         = module.security.ec2_sg_id
}

# RDS module
module "rds" {
  source                = "./modules/rds"
  db_username           = var.db_username
  db_password           = var.db_password
  vpc_security_group_ids = [module.security.ec2_sg_id]
  db_subnet_ids         = module.vpc.private_subnet_ids
  db_name               = var.db_name
}