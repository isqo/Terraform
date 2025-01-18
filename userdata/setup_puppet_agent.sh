
wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update

sudo apt install puppet-agent

export PATH=$PATH:/opt/puppetlabs/bin
sudo /opt/puppetlabs/bin/puppet --version

echo 172.31.1.182 puppet >> /etc/hosts

puppet ssl bootstrap