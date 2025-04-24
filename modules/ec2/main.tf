

resource "aws_instance" "wordpress" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install -y php7.4
    yum install -y httpd mariadb php php-mysqlnd
    systemctl enable httpd
    systemctl start httpd
    cd /var/www/html
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz
    cp -r wordpress/* .
    rm -rf wordpress latest.tar.gz
    chown -R apache:apache /var/www/html
    chmod -R 755 /var/www/html
  EOF

  tags = {
    Name = "wordpress-ec2"
  }
}