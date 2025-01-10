
wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update
sudo apt install puppet-agent
sudo puppet --version

echo $(hostname -i) puppet >> /etc/hosts