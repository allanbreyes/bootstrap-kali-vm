# -*- mode: ruby -*-
# vi: set ft=ruby :
NAME = "kali".freeze

Vagrant.configure("2") do |config|
  config.ssh.forward_x11 = true

  config.vm.box = "kalilinux/rolling"
  config.vm.define NAME
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.linked_clone = true
    vb.memory = "4096"
    vb.name = NAME
  end
  config.vm.provision :file, source: "secrets/ssh", destination: "$HOME/.ssh"
  config.vm.provision :shell, path: "bootstrap-kali.sh"
  config.vm.synced_folder "share/", "/share"
end
