wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update

sudo apt install puppet-agent

export PATH="/opt/puppetlabs/bin/:$PATH"

puppet --version

echo ${var.puppetserver_private_ip} puppet >> /etc/hosts