resource "aws_security_group" "ec2_sg" {
  name        = "wordpress-ec2-sg"
  description = "Allow HTTP from ALB"
  vpc_id      = var.vpc_id

  # Ingress rule to allow HTTP access from anywhere (for temporary testing)
  ingress {
    description = "Allow HTTP from anywhere (for testing)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Temporary SSH access for testing
  ingress {
    description = "Allow SSH from anywhere (temporary for testing)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Commented out for cost-saving during development phase (no Bastion Host needed)
# resource "aws_security_group" "bastion_sg" {
#   name        = "bastion-sg"
#   description = "Allow SSH from trusted IP"
#   vpc_id      = var.vpc_id
#
#   ingress {
#     description = "SSH access from trusted IP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = [var.ssh_access_cidr]
#   }
#
#   egress {
#     description = "Allow all outbound traffic"
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#
#   tags = {
#     Name = "bastion-sg"
#   }
# }

# Commented out for cost-saving during development phase (no Bastion Host needed)
# resource "aws_security_group_rule" "ssh_from_bastion_to_ec2" {
#   type                     = "ingress"
#   from_port                = 22
#   to_port                  = 22
#   protocol                 = "tcp"
#   security_group_id        = aws_security_group.ec2_sg.id
#   source_security_group_id = aws_security_group.bastion_sg.id
#   description              = "Allow SSH from Bastion to EC2"
# }