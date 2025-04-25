output "alb_dns_name" {
  value       = aws_lb.wordpress_alb.dns_name
  description = "DNS name of the Application Load Balancer"
}

output "target_group_arn" {
  value       = aws_lb_target_group.wordpress_tg.arn
  description = "ARN of the target group"
}