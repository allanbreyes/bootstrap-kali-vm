# -*- mode: ruby -*-
# vi: set ft=ruby :
NAME = "kali".freeze

Vagrant.configure("2") do |cfg|
  cfg.vm.box = "kalilinux/rolling"
  cfg.vm.define NAME
  cfg.vm.provider :virtualbox do |vb|
    vb.cpus = 2
    vb.gui = false
    vb.linked_clone = true
    vb.memory = "8192"
    vb.name = NAME
  end
  cfg.vm.provision "ansible" do |ab|
    ab.become = true
    ab.playbook = "playbook.yml"
    ab.raw_arguments = [ "-e", "ansible_python_interpreter=/usr/bin/python3" ]
    ab.verbose = true
  end
  cfg.vm.synced_folder ".", "/vagrant", disabled: true
  cfg.vm.synced_folder "./share/", "/share"
end
