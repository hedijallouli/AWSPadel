


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