# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = 'guyirvine/ruby-dev'

  config.vm.provision :shell, path: 'bin/bootstrap.sh'

  config.vm.network 'forwarded_port', guest: 4000, host: 4000

end
