# -*- mode: ruby -*-
# vi: set ft=ruby :
$scriptServ= <<SCRIPT

sudo yum -y install unzip vim net-tools htop java-devel epel-release git

sudo yum -y install nginx

sudo systemctl start nginx
sudo systemctl enable nginx

wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
$(java -jar jenkins.war) & 

#sudo echo -e "192.168.33.11	jenkins" >> /etc/hosts

#sudo sed -i.back '/^        location/a \ proxy_pass http://192.168.33.11:8080;' /etc/nginx/nginx.conf


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
