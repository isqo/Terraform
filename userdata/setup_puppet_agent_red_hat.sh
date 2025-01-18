sudo rpm -Uvh https://yum.puppet.com/puppet8-release-el-8.noarch.rpm

sudo yum -y install puppet-agent

sudo /opt/puppetlabs/bin/puppet --version

sudo echo 172.31.1.182 puppet >> /etc/hosts

sudo /opt/puppetlabs/bin/puppet ssl bootstrap