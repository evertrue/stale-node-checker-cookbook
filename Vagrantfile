# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_plugin "vagrant-chef-zero"

Vagrant.configure("2") do |config|
  config.vm.hostname = "stale-node-checker-berkshelf"
  config.omnibus.chef_version = :latest
  config.vm.box = "precise64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box"
  config.vm.network :private_network, ip: "33.33.33.10"
  config.berkshelf.enabled = true

  config.vm.synced_folder "#{ENV['HOME']}/.chef", "/tmp/local-chef"

  if ENV['CHEF_REPO']
    chef_repo = ENV['CHEF_REPO']
  else
    raise "CHEF_REPO is not defined"
  end

  config.chef_zero.chef_repo_path = ".chef-zero/"

  config.vm.provision :chef_client do |chef|
    chef.json = {
      'stale-node-checker' => {
        'alert-email' => 'eric.herot@evertrue.com'
      }
    }
    chef.environment = "stage"
    chef.log_level = :info

    chef.run_list = [
        "recipe[postfix]",
        "recipe[stale-node-checker::default]"
    ]
  end
end
