Vagrant.configure("2") do |config|

  config.vm.define "frr_router1" do |frr_router1|
    frr_router1.vm.box = "ubuntu/trusty64"
    frr_router1.vm.hostname = "frr-router1"
    frr_router1.vm.network "private_network", virtualbox__intnet: "swp1", ip: "192.168.0.1/30"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp2"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp3"
    # frr_router1.vm.network "private_network", virtualbox__intnet: "swp4"
    config.vm.synced_folder "../frrouting", "/home/vagrant"
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y libc-ares2
      wget https://github.com/FRRouting/frr/releases/download/frr-3.0.2/frr_3.0.2-1-ubuntu14.04.1_amd64.deb
      dpkg -i frr_3.0.2-1-ubuntu14.04.1_amd64.deb
      usermod -a -G frr vagrant
      chmod -R 775 /etc/frr/
      chmod 646 /etc/services
      cp /home/vagrant/frr_router_1_daemons /etc/frr/daemons
      cp /home/vagrant/frr_router_1_config /etc/frr/bgpd.conf
      cat /home/vagrant/services >> /etc/services
      service frr restart
    SHELL
  end

end