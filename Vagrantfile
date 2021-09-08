# -*- mode: ruby -*-
# vi: set ft=ruby :
NAME = "kali".freeze

Vagrant.configure("2") do |config|
  config.vm.box = "kalilinux/rolling"
  config.vm.define NAME
  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.linked_clone = true
    vb.memory = "4096"
    vb.name = NAME
  end
  {
    "dotfiles/profile.sh" => "$HOME/.profile",
    "secrets/gpg" => "$HOME/.gpg",
    "secrets/ssh" => "$HOME/.ssh",
  }.each do |src, dst|
    config.vm.provision :file, source: src, destination: dst
  end
  config.vm.provision :shell, path: "bootstrap-kali.sh"
  config.vm.synced_folder "share/", "/share"
end
