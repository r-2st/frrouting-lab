Vagrant.configure("2") do |config|

  config.vm.define "frr_router1" do |frr_router1|
    frr_router1.vm.box = "ubuntu/trusty64"
    frr_router1.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--memory", "512"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
    end
    frr_router1.vm.hostname = "frr-router1"
    frr_router1.vm.network "private_network", virtualbox__intnet: "swp1", ip: "192.168.0.1/30"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp2"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp3"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp4"
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y frr
    SHELL
  end

end