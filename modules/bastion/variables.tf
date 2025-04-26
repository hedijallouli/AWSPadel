


variable "ami_id" {
  description = "AMI ID for the Bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Bastion host"
  type        = string
  default     = "t2.micro"
}

variable "public_subnet_id" {
  description = "Subnet ID for the Bastion host"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the Bastion host"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
}