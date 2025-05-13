# resource "aws_instance" "wordpress" {
#   ami                    = var.ami_id
#   instance_type          = var.instance_type
#   subnet_id              = var.public_subnet_id  # TEMPORARY: Using public subnet for dev/testing phase (no NAT Gateway)
#
#   associate_public_ip_address = true  # TEMPORARY: Associate a public IP to EC2 for direct access (remove later)
#
#   vpc_security_group_ids = [var.security_group_id]
#   key_name               = var.key_name
#
#   user_data = templatefile("${path.module}/user_data.sh", {
#     db_name     = var.db_name
#     db_username = var.db_username
#     db_password = var.db_password
#     db_host     = var.db_host
#   })
#
#   tags = {
#     Name = "wordpress-ec2"
#   }
# }

resource "aws_instance" "wordpress" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = templatefile("${path.module}/user_data.sh", {
    db_name     = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    db_host     = var.db_host
  })

  tags = {
    Name = "wordpress-ec2"
  }
}

resource "aws_lb_target_group_attachment" "wordpress_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}