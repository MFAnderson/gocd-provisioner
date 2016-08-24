# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = 'gocd'

  config.vm.box = "centos/6"
  #I guess if you're weird and run Debian in prod
  #config.vm.box = "debian/jessie64"

  config.vm.network "forwarded_port", guest: 8153, host: 8153

  #no dir sync needed
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
  
  config.vm.provision "ansible" do |ansible|
    ansible.host_key_checking = false
    ansible.playbook = "cd-provisioning/site.yml"
    ansible.groups = {
      "go-server" => ["default"],
      "go-agent" => ["default"],
      "artifactory" => ["default"]
    }
    ansible.verbose = ''
  end

end
