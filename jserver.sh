#!/bin/bash
echo "Jenkins Server Provisioning."

#Installing Java
echo "1.Installing prerequisites (JRE, JDK, Git, Environment)"
#JRE
yum -y install java
#JDK (with local repo check)
if [[ -f /vagrant/redist/jdk-8u151-linux-x64.rpm ]]; then
  echo "Found local jdk rpm file. Installing."
  yum -y install /vagrant/redist/jdk-8u151-linux-x64.rpm
else
  echo "Local jdk rpm file not found. Downloading and installing."
  wget -q --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
"http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.rpm"
  yum -y install jdk-8u151-linux-x64.rpm
fi
#Git
yum -y install git
#Environment
mkdir -p /opt/jenkins
mkdir /opt/jenkins/output
mkdir /opt/jenkins/backup
mkdir /opt/jenkins/bin
mkdir /opt/jenkins/master

#Installing and running Jenkins
echo "2. Installing and running Jenkins"
#Jenkins itself
groupadd jenkins
useradd -g jenkins jenkins
#Checking for local repository
if [[ -f /vagrant/redist/jenkins.war ]]; then
  echo "Found local jenkins.war file. Copying."
  cp -f /vagrant/redist/jenkins.war /opt/jenkins/bin/
else
  echo "Local jenkins.war file not found. Downloading and copying."
  wget -q "http://mirrors.jenkins.io/war-stable/latest/jenkins.war"
  mv -f jenkins.war /opt/jenkins/bin/jenkins.war
fi
chown -R jenkins:jenkins /opt/jenkins
#Config restoration (if exists)
if [[ -f /vagrant/conf/jconf.tar.gz ]]; then
  echo "Config backup found. Restoring."
  tar -zxvf /vagrant/conf/jconf.tar.gz -C /opt/jenkins/master/
else
  echo "Config backup not found."
fi
#Jenkins service
cp -f /vagrant/jenkins.service /lib/systemd/system/
cp -f /vagrant/jenkins.env /etc/sysconfig/
systemctl enable jenkins
systemctl start jenkins

#Installing and running Nginx
echo "3. Installing and running NginX"
yum -y install http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
yum -y install nginx
mkdir -p /etc/nginx/vhosts
cp -f /vagrant/nginx.conf /etc/nginx/nginx.conf
cp -f /vagrant/vhost.conf /etc/nginx/vhosts/vhost.conf
systemctl enable nginx
systemctl start nginx

#Installing debug tools
echo "4. Installing debug tools (Net-Tools, Htop)"
yum -y install net-tools htop
