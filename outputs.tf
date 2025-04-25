output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "DNS name of the Application Load Balancer"
}

output "wordpress_instance_id" {
  value       = module.ec2.instance_id
  description = "ID of the WordPress EC2 instance"
}

output "rds_endpoint" {
  description = "RDS endpoint address"
  value       = module.rds.rds_endpoint
}