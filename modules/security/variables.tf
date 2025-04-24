variable "vpc_id" {
  description = "VPC ID to associate with the security group"
  type        = string
}

variable "ssh_access_cidr" {
  description = "CIDR allowed for SSH access"
  type        = string
}