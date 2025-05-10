variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance to launch"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of the key pair for SSH access"
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR block for SSH access to EC2 instance"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Database name for the RDS instance"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 Instance type for the Bastion host"
  type        = string
  default     = "t2.micro"
}

variable "user_data_base64" {
  description = "Base64-encoded user data script for EC2 instances"
  type        = string
}