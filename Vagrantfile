Vagrant.configure(2) do |config|
    config.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
    config.vm.hostname = "jenkins"
    config.vm.network :private_network, ip: "192.168.56.101"
    config.ssh.insert_key = false
    config.vm.provider :virtualbox do |v|
      v.customize [
	"modifyvm", :id,
	"--natdnshostresolver1", "on",
	"--memory", 2048,
	"--name", "jenkins"
	]
    end
    config.vm.provision "shell", path: "java_setup.sh"
    config.vm.provision "shell", path: "nginx_setup.sh"
    config.vm.provision "shell", path: "jenkins_setup.sh" 
end
