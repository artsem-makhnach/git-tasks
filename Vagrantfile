Vagrant.configure("2") do |config|

    
   config.vm.define "server" do |server| 
   server.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
   server.vm.hostname = "server"
   server.vm.network "private_network", type: "dhcp" 
   server.vm.provider 'virtualbox' do |vb|
        vb.memory="2048"  
	vb.name = "server"
   end
   server.vm.provision 'shell', inline: <<-EOF
    sudo yum -y install vim
    sudo yum -y install mc
    sudo yum -y install net-tools
    sudo yum -y install java-devel
    sudo yum -y install zip unzip 
    sudo yum -y install mlocate	    
    sudo mkdir "/opt/jenkins/bin"
    sudo cd "/opt/jenkins/bin"
    #sudo wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
    sudo useradd jenkins
    sudo export JENKINS_HOME=/opt/jenkins/master
    sudo export JENKINS_DIR=/opt/jenkins/bin
    sudo cp /vagrant/jenkins.war /opt/jenkins/bin/jenkins.war
    sudo chown -R jenkins:jenkins /opt/jenkins
    sudo echo "127.0.0.1 jenkins" >> /etc/hosts
    sudo yum install -y nginx
    sudo cp /vagrant/nginx.conf /etc/nginx/nginx.conf
    sudo start nginx 
  EOF
  end




  
end
