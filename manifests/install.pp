class al_kcare::install {

  if ( $::osfamily == 'RedHat' ) {
    # Handling of RedHat OS

    if ($::al_kcare::real_enabled) {
      # Install RedHat

      package { 'kernelcare':
        ensure  => latest,
        require => Class['al_kcare::repo'],
        # install_options => ['-y'],
      }

    } else {

      # Uninstall RedHat
      if ( $::osfamily == 'RedHat' ) {
        package { 'kernelcare':
          ensure  => absent,
          require => Class['al_kcare::register'],
        }

      }
    }
  }
}
