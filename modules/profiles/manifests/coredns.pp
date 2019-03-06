class profiles::coredns (
  Array[String] $consulservers
){

  include ::coredns

  coredns::plugin { 'consul_forward':
    content => template('profiles/coredns/consul_forward.erb'),
  }


}
