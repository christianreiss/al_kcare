class al_kcare::register {

  if ($::al_kcare::real_enabled) {
    # We want kernelcare to run.

    if ($::al_kcare::license) {
      # and we have a license, register it.

      exec { 'register-kernelcare':
        user    => 'root',
        # command => "${::al_kcare::kcare_bin} --register ${::al_kcare::license} && echo 'REGDONE' > ${::al_kcare::register_file}",
        command => "${::al_kcare::kcare_bin} --register ${::al_kcare::license}",
        creates => $::al_kcare::register_file,
        require => Class['al_kcare::install']
      }

      # Install our own cron.
      cron { 'kcare-update':
        ensure  => present,
        command => '/usr/bin/kcarectl --auto-update 2>/dev/null 1>/dev/null >/dev/null',
        hour    => '*/4',
        minute  => fqdn_rand(59, 'kcare-update'),
      }

      # Remove the stock-cron.
      file { '/etc/cron.d/kcare-cron':
        ensure => absent,
      }
    }

  } else {
    # Disabled, de-register.

    exec { 'unregister-kernelcare':
      user    => 'root',
      command => "${::al_kcare::kcare_bin} --unregister && rm -f ${::al_kcare::register_file}",
      onlyif  => "test -e ${::al_kcare::register_file}",
      before  => Class['al_kcare::install'],
    }

    # Remove our cron.
    cron { 'kcare-update':
      ensure => absent,
    }
  }

  #
  # Temporary Cleanup
  #
  if ($::osfamily == 'RedHat') {
    file { '/etc/sysconfig/kcare/registered':
      ensure => absent,
    }
  }

}
