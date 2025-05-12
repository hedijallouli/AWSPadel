#!/bin/bash
yum update -y

# Install required packages
yum install -y httpd php php-mysqlnd php-fpm wget unzip

# Create /var/www/html if not exists
mkdir -p /var/www/html

# Enable and start Apache and PHP-FPM
systemctl enable httpd
systemctl start httpd
systemctl enable php-fpm
systemctl start php-fpm

# Create a dynamic PHP info page for Auto Scaling testing
mkdir -p /var/www/html/info
cat <<EOT > /var/www/html/info/index.php
<?php
  \$az = @file_get_contents("http://169.254.169.254/latest/meta-data/placement/availability-zone") ?: 'Unavailable';
  \$ip = @file_get_contents("http://169.254.169.254/latest/meta-data/public-ipv4") ?: 'Unavailable';
?>
<h1>Instance Info</h1>
<p>AZ: <?= htmlspecialchars(\$az) ?></p>
<p>Public IP: <?= htmlspecialchars(\$ip) ?></p>
EOT

# Download and set up WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Set correct permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure Apache for WordPress
cat <<EOT > /etc/httpd/conf.d/wordpress.conf
<Directory /var/www/html>
    DirectoryIndex index.php index.html
    AllowOverride All
    Require all granted
</Directory>
EOT

# Inject database configuration into wp-config.php
sed -i "s/database_name_here/${db_name}/" /var/www/html/wp-config.php
sed -i "s/username_here/${db_username}/" /var/www/html/wp-config.php
sed -i "s/password_here/${db_password}/" /var/www/html/wp-config.php
sed -i "s/localhost/${db_host}/" /var/www/html/wp-config.php

# Restart Apache to apply changes
systemctl restart httpd