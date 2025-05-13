# modules/rds/outputs.tf

output "rds_endpoint" {
  description = "The RDS endpoint"
  value       = aws_db_instance.this.endpoint
}

output "rds_sg_id" {
  description = "The security group ID associated with the RDS instance"
  value       = aws_security_group.rds_sg.id
}