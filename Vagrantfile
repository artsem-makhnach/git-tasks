Vagrant.configure(2) do |config|
  config.vm.define "jenkins" do |jnk|
    jnk.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
    jnk.vm.hostname = "jenkins"
    jnk.vm.network :private_network, type: "dhcp"
    jnk.ssh.insert_key = false
    jnk.vm.provider :virtualbox do |v|
      v.customize [
	"modifyvm", :id,
	"--natdnshostresolver1", "on",
	"--memory", 2048,
	"--name", "jenkins"
	]
    end
    jnk.vm.provision 'shell', inline: <<-EOF
    echo "Machine Host-only adapter IP adress: $(nmcli d show enp0s8 | grep IP4.ADDRESS | tr -s " " | cut -d " " -f 2)"
    EOF
    jnk.vm.provision "shell", path: "java_setup.sh"
    jnk.vm.provision "shell", path: "nginx_setup.sh"
    jnk.vm.provision "shell", path: "jenkins_setup.sh" 
  end
end
