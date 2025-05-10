resource "aws_security_group" "ec2_sg" {
  name        = "wordpress-ec2-sg"
  description = "Allow HTTP from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "wordpress-ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http" {
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow HTTP from anywhere (for testing)"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ssh" {
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow SSH from anywhere (temporary for testing)"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
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