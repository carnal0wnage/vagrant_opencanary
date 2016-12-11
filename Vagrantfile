# -*- mode: ruby -*-
# vi: set ft=ruby :

VBOX = "ubuntu/trusty64"

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = VBOX
  config.vm.network "public_network"

  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", 2048]
    v.customize ["modifyvm", :id, "--cpus", 2 ]
  end

  config.vm.provision "shell", path: "scripts/buildwin_mssqlrdp.sh"
end
