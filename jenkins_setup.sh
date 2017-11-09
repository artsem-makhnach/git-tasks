#!/bin/bash

#Installing dependencies
yum -y install git > /dev/null 2>&1

#Script for Installation and Configuration Jenkins
mkdir -p /opt/jenkins/master
mkdir -p /opt/jenkins/bin
wget -qO /opt/jenkins/bin/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war

useradd jenkins
chown -R jenkins: /opt/jenkins/

cat > /etc/systemd/system/jenkins.service <<-EOF
	[Unit]
	Description=Jenkins Daemon
	
	[Service]
	Environment=JENKINS_HOME=/opt/jenkins/master
	Environment=JENKINS_DIR=/opt/jenkins/bin
	ExecStart=/usr/bin/java -jar /opt/jenkins/jenkins.war
	User=jenkins
	
	[Install]
	WantedBy=multi-user.target
EOF

systemctl enable jenkins
systemctl start jenkins
