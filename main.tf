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

#
# ----------------------------------------------------------------------
# Bastion Host Setup (Temporary)
#
# This EC2 instance is deployed in a public subnet to serve as a jump box
# for securely accessing the WordPress EC2 instance deployed in a private subnet.
#
# It uses a dedicated security group that allows SSH access only from the
# user's IP address (defined via ssh_access_cidr). Additionally, a separate
# security group rule is configured to allow this bastion to reach the
# private EC2 instance over port 22 (SSH).
#
# Once an Application Load Balancer (ALB) is deployed to access WordPress
# over HTTP, and optionally SSM is configured for secure management,
# this bastion instance can be removed.
# ----------------------------------------------------------------------
#
# Bastion security group
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from your IP"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# Bastion EC2 instance in public subnet
resource "aws_instance" "bastion" {
  ami                    = var.ami_id
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_subnet_ids[0]
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "bastion-host"
  }
}

#
# This rule allows the bastion host to SSH into the private EC2 instance.
# It's critical for jump box access, and can be removed once SSM or ALB routing is fully in place.
#
resource "aws_security_group_rule" "ssh_from_bastion_to_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.security.ec2_sg_id
  source_security_group_id = aws_security_group.bastion_sg.id

  description = "Allow SSH from bastion SG to EC2 SG"
}
