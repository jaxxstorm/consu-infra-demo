class profiles::base(

){

  class { '::profiles::packages':
    stage => pre
  }

  include ::puppet

  include ::profiles::consul

  include ::profiles::coredns

  class { 'resolv_conf':
    nameservers => ['127.0.0.1', '173.245.58.51', '8.8.8.8'],
  }




}
