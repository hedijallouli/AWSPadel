resource "aws_instance" "wordpress" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    dnf update -y
    dnf install -y httpd php php-mysqli php-fpm mariadb wget tar

    # Start services
    systemctl enable --now httpd
    systemctl enable --now php-fpm

    # Configure Apache to use PHP-FPM
    cat <<EOC > /etc/httpd/conf.d/php.conf
    <FilesMatch \.php$>
        SetHandler "proxy:unix:/run/php-fpm/www.sock|fcgi://localhost"
    </FilesMatch>

    DirectoryIndex index.php
    EOC

    # Set up WordPress
    mkdir -p /var/www/html
    cd /var/www/html
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* .
    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html

    # Configure WordPress to use RDS
    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/${db_name}/" /var/www/html/wp-config.php
    sed -i "s/username_here/${db_username}/" /var/www/html/wp-config.php
    sed -i "s/password_here/${db_password}/" /var/www/html/wp-config.php
    sed -i "s/localhost/${db_host}/" /var/www/html/wp-config.php

    systemctl restart httpd
  EOF

  tags = {
    Name = "wordpress-ec2"
  }
}
resource "aws_lb_target_group_attachment" "wordpress_attachment" {
  target_group_arn = var.target_group_arn
  target_id        = aws_instance.wordpress.id
  port             = 80
}