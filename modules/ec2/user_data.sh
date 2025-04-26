

#!/bin/bash
yum update -y
amazon-linux-extras enable php8.2
yum clean metadata
yum install -y php php-cli php-mysqlnd php-fpm php-json php-common php-mbstring php-xml php-gd php-curl
yum install -y httpd wget

systemctl start httpd
systemctl enable httpd

cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .
rm -rf wordpress latest.tar.gz

# Set correct permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Configure Apache to work with PHP
echo "<IfModule dir_module>
    DirectoryIndex index.php index.html
</IfModule>" > /etc/httpd/conf.d/dir.conf

systemctl restart httpd