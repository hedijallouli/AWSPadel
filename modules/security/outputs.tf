output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "bastion_sg_id" {
  description = "Security Group ID for the Bastion host"
  value       = aws_security_group.bastion_sg.id
}

output "alb_sg_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}