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
    config.vm.provision "file", source: "frr_router_1_daemon", destination: "/etc/frr/daemon"
    config.vm.provision "file", source: "frr_router_1_config", destination: "/etc/frr/bgpd.conf"
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install libc-ares2
      wget https://github.com/FRRouting/frr/releases/download/frr-3.0.2/frr_3.0.2-1-ubuntu14.04.1_amd64.deb
      dpkg -i frr_3.0.2-1-ubuntu14.04.1_amd64.deb
    SHELL
  end

end