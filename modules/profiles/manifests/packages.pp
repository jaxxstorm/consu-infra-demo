class profiles::packages {

  package { [
      'wget',
    ]:
    ensure => installed,
  }

}
