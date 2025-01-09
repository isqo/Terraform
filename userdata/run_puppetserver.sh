wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update
sudo apt-get --yes install puppetserver
sudo service puppetserver start
sudo puppetserver --version