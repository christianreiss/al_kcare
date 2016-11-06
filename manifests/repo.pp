class al_kcare::repo {

  #
  # This class manages the Repositores.
  #

  # Handling of RPM Servers
  if ( $::osfamily == 'RedHat' ) {
    # RedHat Family found.

    if ($::al_kcare::real_enabled) {
      # Install RedHat Servers.

      yumrepo { 'kernelcare':
        ensure    => present,
        name      => 'kernelcare',
        assumeyes => true,
        baseurl   => 'http://repo.cloudlinux.com/kernelcare/6/$basearch',
        gpgkey    => 'http://repo.cloudlinux.com/kernelcare-debian/6/conf/kcaredsa_pub.gpg',
        gpgcheck  => true,
        enabled   => true,
      }

    }  else {
      # We want it removed.

      yumrepo { 'kernelcare':
        ensure => absent,
        name   => 'kernelcare',
      }
    }
  }

  # Handling of Debian

  # Etc

}
