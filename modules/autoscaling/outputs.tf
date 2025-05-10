

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.name
}

output "asg_arn" {
  description = "The ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.arn
}

output "launch_template_id" {
  description = "The ID of the launch template used"
  value       = aws_launch_template.wordpress_launch_template.id
}

output "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.min_size
}

output "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.max_size
}

output "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  value       = aws_autoscaling_group.wordpress_asg.desired_capacity
}