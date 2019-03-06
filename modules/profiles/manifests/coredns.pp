class profiles::coredns (
  Array[String] $consulservers
){

  include ::coredns

  coredns::plugin { 'consul_forward':
    content => epp('profiles/coredns/consul_forward.epp'),
  }


}
