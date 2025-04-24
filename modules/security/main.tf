resource "aws_security_group" "ec2_sg" {
  name        = "wordpress-ec2-sg"
  description = "Allow HTTP from ALB and optional SSH"
  vpc_id      = var.vpc_id

  # Ingress rule to allow HTTP access from anywhere (for temporary testing)
  ingress {
    description = "Allow HTTP from anywhere (for testing)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule to allow SSH access only from the specified IP
  ingress {
    description = "Allow SSH from your IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }

  # Egress rule to allow all outbound traffic
  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-ec2-sg"
  }
}

# Allow SSH from bastion host to EC2 instance in the private subnet
resource "aws_security_group_rule" "ssh_from_bastion_to_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.security.ec2_sg_id
  source_security_group_id = aws_security_group.bastion_sg.id

  description = "Allow SSH from bastion SG to EC2 SG"
}