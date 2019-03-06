class profiles::base(
  Array[String] $consul_servers
){

  class { '::profiles::packages':
    stage => pre
  }

  include ::puppet

  include ::profiles::consul

  include ::unbound

  unbound::stub { $::domain :
    address  => '173.245.58.51',
    insecure => true,
  }

  unbound::forward { 'service.consul':
    # We use suffix from stdlib to add the consul DNS port: https://github.com/puppetlabs/puppetlabs-stdlib#suffix
    address => suffix($consul_servers, '@8600')
  }

  unbound::forward { '.':
    address => [ '8.8.8.8', '8.8.4.4' ]
  }




}
