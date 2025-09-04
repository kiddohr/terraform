#!/bin/bash

yum install httpd -y

systemctl start httpd
systemctl enable http

cat <<EOF > /var/www/html/index.html
Server 1
EOF