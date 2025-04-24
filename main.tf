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
  source             = "./modules/ec2"
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  private_subnet_id  = module.vpc.private_subnet_ids[0]
  security_group_id  = module.security.ec2_sg_id
  key_name           = var.key_name
}
