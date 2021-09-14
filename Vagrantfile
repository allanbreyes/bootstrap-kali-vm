# -*- mode: ruby -*-
# vi: set ft=ruby :
NAME = "kali".freeze

Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.define NAME
  config.vm.provider :virtualbox do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
    vb.memory = "8192"
    vb.name = NAME
  end
  config.vm.provision "ansible" do |ab|
    ab.become = true
    ab.playbook = "playbook.yml"
    ab.raw_arguments = [ "-e", "ansible_python_interpreter=/usr/bin/python3" ]
    ab.verbose = true
  end
  # config.vm.provision :shell, path: "bootstrap-kali.sh"
  config.vm.synced_folder "share/", "/share"
end
