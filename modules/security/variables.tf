variable "vpc_id" {
  description = "VPC ID to associate with the security group"
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR allowed for SSH access"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group ID of the Application Load Balancer"
  type        = string
}