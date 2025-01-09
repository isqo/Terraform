wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update

sudo apt --yes install puppet-agent

sudo service puppetserver start
sudo puppetserver --version

