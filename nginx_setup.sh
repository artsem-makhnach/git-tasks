#!/bin/bash

cat > /etc/yum.repos.d/nginx.repo <<-EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/7/x86_64/
gpgcheck=0
enabled=1
EOF

yum -y install nginx > /dev/null 2>&1

mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bkp
cat > /etc/nginx/conf.d/vhost.conf <<-EOF
	server {
	    listen 80 default_server;
	    server_name  localhost;
	    location / {
	        proxy_pass http://localhost:8080;
	    }
	}
EOF

systemctl start nginx
systemctl enable nginx
