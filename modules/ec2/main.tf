

resource "aws_instance" "wordpress" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd php php-mysqli php-fpm tar wget

    systemctl enable --now httpd

    cd /var/www/html
    rm -rf *
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* .
    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html
  EOF

  tags = {
    Name = "wordpress-ec2"
  }
}