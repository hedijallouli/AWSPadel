output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.wordpress.id
}

output "private_ip" {
  description = "Private IP of the EC2 instance"
  value       = aws_instance.wordpress.private_ip
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}