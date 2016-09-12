# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = 'gocd'

  config.vm.box = "centos/6"
  #I guess if you're weird and run Debian in prod
  #config.vm.box = "debian/jessie64"

  config.vm.network "forwarded_port", guest: 8153, host: 8153
  config.vm.network "forwarded_port", guest: 8154, host: 8154
  config.vm.network "forwarded_port", guest: 8081, host: 8081

  #no dir sync needed
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end
  
  config.vm.provision "ansible" do |ansible|
    ansible.host_key_checking = false
    ansible.playbook = "ansible/site.yml"
    ansible.groups = {
      "go-server" => ["default"],
      "go-agent" => ["default"],
      "tag_group_go" => ["default"],
      "artifactory" => ["default"]
    }
    ansible.verbose = ''
    ansible.extra_vars = {
       # ARTIFACTORY_USE_EXTERNAL_DB: true,
       # DB_URL: "dummy",
       # DB_PASSWORD: "dummy"
    }
  end

end
