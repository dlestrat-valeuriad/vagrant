#!/bin/bash
. /vagrant/config/parse_config.sh /vagrant/config/config.yml

# Proxy configuration
echo "proxy=$config_root_proxy" >> /etc/yum.conf