output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "bastion_sg_id" {
  description = "Security Group ID for the Bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "rds_sg_id" {
  description = "Security Group ID for the RDS instance"
  value       = aws_security_group.rds_sg.id
}