# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

class Util
    attr_accessor :logger

    def initialize
        @logger = Vagrant::UI::Colored.new
        @logger.opts[:color] = :green
    end

    def load_file(path)
        if not File.exist?("#{path}")
            @logger.error "---------------------------------------------------------"
            @logger.error "ERROR - File not found: #{path}"
            @logger.error "---------------------------------------------------------"
            exit 1
        end

        YAML.load_file("#{path}")["root"]
    end

end

utils = Util.new

Vagrant.configure("2") do |config|

  local_config  = utils.load_file("config/config.yml")

  config.vm.box = local_config["box_name"]

  config.vm.provider "virtualbox" do |vb|
      vb.name = local_config["vm_name"]
      vb.memory = local_config["vm_ram"]
  end

  config.vm.network "forwarded_port", guest: 22, host: 2221, id: "ssh", auto_correct: true
  config.vm.network "private_network", ip: local_config["vm_ip_address"]

  config.ssh.forward_agent = true
  config.ssh.insert_key = false

  #Provisioning
  config.vm.provision "shell", path: "scripts/provision_root.sh"
  config.vm.provision "shell", path: "scripts/provision_user.sh", privileged: false

end
