Vagrant.configure("2") do |config|

    
   config.vm.define "server" do |server| 
   server.vm.box = "sbeliakou/centos-7.4-x86_64-minimal"
   server.vm.hostname = "server"
   server.vm.network "private_network", ip: "192.168.56.100"
   server.vm.provider 'virtualbox' do |vb|
        vb.memory="2048"  
	vb.name = "server"
   end
   server.vm.provision 'shell', inline: <<-EOF
	    
    
  EOF
  end




  
end
