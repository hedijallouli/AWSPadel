#!/bin/bash
set -e

# Update and install required packages (Amazon Linux 2023 uses dnf)
dnf update -y
dnf install -y httpd php php-mysqlnd wget tar unzip

# Enable and start Apache
systemctl enable httpd
systemctl start httpd

# Setup WordPress
mkdir -p /var/www/html
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Set permissions
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

# Ensure wp-config.php exists before modifying
cp wp-config-sample.php wp-config.php

# Inject database configuration into wp-config.php
sed -i "s/database_name_here/${db_name}/" wp-config.php
sed -i "s/username_here/${db_username}/" wp-config.php
sed -i "s/password_here/${db_password}/" wp-config.php
sed -i "s/localhost/${db_host}/" wp-config.php

# Restart Apache to apply changes
systemctl restart httpd