# modules/rds/outputs.tf

output "rds_endpoint" {
  description = "The RDS endpoint"
  value       = aws_db_instance.this.endpoint
}