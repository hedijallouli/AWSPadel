


variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "private_subnet_id" {
  description = "ID of the private subnet where the instance will be launched"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to associate with the instance"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}

variable "target_group_arn" {
  type        = string
  description = "ARN of the ALB target group"
}

variable "db_name" {
  description = "The database name for WordPress to connect to"
  type        = string
}

variable "db_username" {
  description = "The database username for WordPress"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The database password for WordPress"
  type        = string
  sensitive   = true
}

variable "db_host" {
  description = "The database endpoint (host) for WordPress to connect to"
  type        = string
}