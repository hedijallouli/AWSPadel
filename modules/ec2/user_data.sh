#!/bin/bash
yum update -y
yum install -y httpd php php-mysqlnd wget unzip php-fpm php-opcache php-gd php-curl php-mbstring php-xml php-xmlrpc

systemctl enable httpd
systemctl start httpd
systemctl enable php-fpm
systemctl start php-fpm

cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

cat <<EOT > /etc/httpd/conf.d/wordpress.conf
<Directory /var/www/html>
    DirectoryIndex index.php index.html
    AllowOverride All
    Require all granted
</Directory>
EOT

cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/DB_NAME_PLACEHOLDER/" wp-config.php
sed -i "s/username_here/DB_USERNAME_PLACEHOLDER/" wp-config.php
sed -i "s/password_here/DB_PASSWORD_PLACEHOLDER/" wp-config.php
sed -i "s/localhost/DB_HOST_PLACEHOLDER/" wp-config.php

systemctl restart httpd