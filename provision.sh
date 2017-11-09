#!/bin/bash

echo "Hello vagrant"
yum -y install java
yum -y install nginx
systemctl enable nginx
yum -y install java-1.8.0-openjdk-devel.x86_64
yum -y install git
