resource "aws_security_group" "ec2_sg" {
  name        = "wordpress-ec2-sg"
  description = "Allow HTTP from ALB"
  vpc_id      = var.vpc_id

  tags = {
    Name = "wordpress-ec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_http" {
  security_group_id              = aws_security_group.ec2_sg.id
  from_port                      = 80
  to_port                        = 80
  ip_protocol                    = "tcp"
  referenced_security_group_id   = var.alb_sg_id
  description                    = "Allow HTTP from ALB SG"
}

resource "aws_vpc_security_group_egress_rule" "ec2_all_outbound" {
  security_group_id = aws_security_group.ec2_sg.id
  description       = "Allow all outbound"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Allow SSH from trusted IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH access from trusted IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_access_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group_rule" "ssh_from_bastion_to_ec2" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ec2_sg.id
  source_security_group_id = aws_security_group.bastion_sg.id
  description              = "Allow SSH from Bastion to EC2"
}

resource "aws_vpc_security_group_ingress_rule" "allow_mysql_from_ec2" {
  security_group_id            = aws_security_group.rds_sg.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = var.ec2_sg_id
  description                  = "Allow MySQL from EC2 SG"
}