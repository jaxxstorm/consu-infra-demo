class profiles::base(

){

  class { '::profiles::packages':
    stage => pre
  }

  include ::puppet

  include ::profiles::consul




}
