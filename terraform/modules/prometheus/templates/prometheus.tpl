#cloud-config
hostname: "${fqdn}"
fqdn: "${fqdn}"

yum_repos:
  puppet:
    baseurl: https://yum.puppetlabs.com/el/7/PC1/x86_64/
    enabled: 1
    gpgcheck: 0
    name: PuppetLabs

packages:
  - ruby
  - ruby-devel
  - git
  - vim
  - bind-utils
 
runcmd:
  - yum install -y https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm
  - yum install -y puppet-agent
  - mkdir -p /etc/facter/facts.d
  - echo -e "nameserver 173.245.58.51\nnameserver 8.8.8.8" > /etc/resolv.conf
  - echo -e "[main]\ncertname = ${fqdn}" >> /etc/puppetlabs/puppet/puppet.conf
  - sed -i '/\[main\]/a dns_alt_names=consul.service.consul,vault.service.consul' /etc/puppetlabs/puppet/puppet.conf
  - until /opt/puppetlabs/puppet/bin/puppet agent -t --server=puppetserver-0.${domain}; do echo "puppet failed, retry in 10 seconds"; sleep 10; done

write_files:
  - path: /etc/facter/facts.d/role.txt
    content: |
      role=prometheus
      domain=${domain}

output:
  all: ">> /var/log/cloud-init.log"
