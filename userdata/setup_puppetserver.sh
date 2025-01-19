    wget https://apt.puppet.com/puppet7-release-focal.deb
sudo dpkg -i puppet7-release-focal.deb
sudo apt update

sudo apt-get --yes install puppetserver

sudo service puppetserver start

sudo /opt/puppetlabs/server/bin/puppetserver --version

echo 172.31.1.182 puppet >> /etc/hosts

#accept automatic signing
echo "*" > /etc/puppetlabs/puppet/autosign.conf

sudo apt --yes install ruby-rubygems
sudo gem install r10k
sudo curl https://raw.githubusercontent.com/isqo/control-repo/refs/heads/production/r10k.yaml -o /etc/puppetlabs/puppet/r10k.yaml
sudo curl https://raw.githubusercontent.com/isqo/control-repo/refs/heads/production/hiera.yaml -o /etc/puppetlabs/puppet/hiera.yaml


# The location to use for storing cached Git repos
#:cachedir: '/var/cache/r10k'
# A list of git repositories to create
#:sources:
# This will clone the git repository and instantiate an environment per
# branch in /etc/puppet/environments
  #:opstree:
#remote: 'https://github.com/isqo/control-repo.git'
    #remote: 'https://github.com/isqo/control-repo.git'
    #basedir: '/etc/puppet/environments'
