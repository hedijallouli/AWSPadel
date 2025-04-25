


variable "public_subnet_ids" {
  type        = list(string)
  description = "List of public subnet IDs for the ALB"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the ALB and target group are created"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for the ALB"
}