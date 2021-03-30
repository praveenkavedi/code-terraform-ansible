#!/bin/bash
yum install httpd -y
systemctl start httpd
systemctl enable httpd
echo "Webserver1" > /var/www/html/index.html
