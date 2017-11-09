# -*- mode: ruby -*-
# vi: set ft=ruby :
$scriptServ= <<SCRIPT

sudo yum -y install vim net-tools htop java-devel epel-release git
sudo yum -y install nginx


groupadd jenkins
useradd jenkins -g jenkins -M

sudo mkdir /opt/jenkins
sudo mkdir /opt/jenkins/bin

export JENKINS_HOME=/opt/jenkins/master
export JENKINS_DIR=/opt/jenkins/bin
sudo bash -c 'echo "JENKINS_HOME=/opt/jenkins/master" >> /etc/environment'
sudo bash -c 'echo "JENKINS_DIR=/opt/jenkins/bin" >> /etc/environment'

wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -O /opt/jenkins/bin/jenkins.war

sudo echo -e "127.0.0.1 jenkins" >> /etc/hosts

###############init.d script
#sudo cp /vagrant/jenkins /etc/init.d/jenkins
#sudo chmod +x /etc/init.d/jenkins  
#sudo service jenkins start

##############systemd script                          
sudo cp /vagrant/jenkins.service /etc/systemd/system/multi-user.target.wants/jenkins.service
sudo systemctl daemon-reload
sudo systemctl start jenkins

sudo sed -i '/^        location/a \ proxy_pass http://127.0.0.1:8080;' /etc/nginx/nginx.conf

sudo systemctl start nginx
sudo systemctl enable nginx

SCRIPT


Vagrant.configure("2") do |config|

  config.vm.define "jboss" do |jboss|
		jboss.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
		jboss.vm.network "private_network", type: "dhcp"
		jboss.vm.provision "shell", inline: $scriptServ
		jboss.vm.provider "virtualbox" do |v|
  			v.memory = 1024
		end	
	end
end
