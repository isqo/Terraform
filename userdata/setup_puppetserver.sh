wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update

sudo apt-get --yes install puppetserver

sudo service puppetserver start

sudo /opt/puppetlabs/server/bin/puppetserver --version

echo $(hostname -i) puppet >> /etc/hosts

#accept automatic signing
echo "*" > /etc/puppetlabs/puppet/autosign.conf

sudo apt --yes install ruby-rubygems
sudo gem install r10k
sudo curl https://raw.githubusercontent.com/isqo/control-repo/refs/heads/production/r10k.yaml -o /etc/puppetlabs/puppet/r10k.yaml
