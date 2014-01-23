# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network "forwarded_port", guest: 50030, host: 51130
  config.vm.synced_folder "/Users/bezidejni/Documents/faks/diplomski/rznu/lab1/restapi/hadoop", "/hadoop"
  config.vm.provision :shell, :inline => "sudo apt-get update"
  config.vm.provision :chef_solo do |chef|
   chef.cookbooks_path = "cookbooks"
   chef.add_recipe 'java'
   chef.add_recipe 'hadoop'
  end
end
