variable "launch_template_id" {
  description = "The ID of the launch template used for the Auto Scaling group"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "List of subnet IDs where the Auto Scaling group will launch instances"
  type        = list(string)
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}

variable "target_group_arns" {
  description = "List of target group ARNs for the Auto Scaling group"
  type        = list(string)
  default     = []
}

variable "health_check_type" {
  description = "The service to use for the health checks"
  type        = string
  default     = "EC2"
}

variable "user_data_base64" {
  description = "Base64-encoded user data script"
  type        = string
}

variable "ami_id" {
  description = "AMI ID used to launch EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the Auto Scaling group"
  type        = string
}

variable "key_name" {
  description = "Key pair name to access EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instances"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the Auto Scaling group"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Target group ARN for attaching the instances to the ALB"
  type        = string
}