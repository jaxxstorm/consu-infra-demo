class profiles::packages {

  package { [
      'wget',
      'unzip',
    ]:
    ensure => installed,
  }

}
