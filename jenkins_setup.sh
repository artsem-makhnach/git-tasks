#!/bin/bash

#Installing dependencies
yum -y install git > /dev/null 2>&1

#Script for Installation and Configuration Jenkins
mkdir -p /opt/jenkins/master
mkdir -p /opt/jenkins/bin
wget -qO /opt/jenkins/bin/jenkins.war http://mirrors.jenkins.io/war-stable/latest/jenkins.war

#Restoring Jenkins config if exists
if [ -e /vagrant/jenkins_backup.tar.gz ]&&[ -e /vagrant/plugins.txt ]; then
   tar -C /opt/jenkins/master -xzf /vagrant/jenkins_backup.tar.gz
   while read line ; do
      curl -L --silent --output /root/.jenkins/plugins/$line.hpi https://updates.jenkins-ci.org/latest/$line.hpi
   done < /vagrant/plugins.txt
fi


useradd jenkins
chown -R jenkins: /opt/jenkins/

cat > /etc/systemd/system/jenkins.service <<-EOF
	[Unit]
	Description=Jenkins Daemon
	
	[Service]
	Environment=JENKINS_HOME=/opt/jenkins/master
	Environment=JENKINS_DIR=/opt/jenkins/bin
	ExecStart=/usr/bin/java -jar /opt/jenkins/master/jenkins.war
	User=jenkins
	
	[Install]
	WantedBy=multi-user.target
EOF

systemctl enable jenkins
systemctl start jenkins
