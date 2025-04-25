# modules/rds/variables.tf

variable "db_name" {
  description = "Name of the initial database"
  type        = string
}

variable "db_username" {
  description = "Master username for the database"
  type        = string
}

variable "db_password" {
  description = "Master password for the database"
  type        = string
  sensitive   = true
}

variable "vpc_security_group_ids" {
  description = "List of VPC security groups to associate"
  type        = list(string)
}

variable "db_subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}
