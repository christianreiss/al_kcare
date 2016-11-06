class al_kcare::register {

  if ($::al_kcare::real_enabled) {
    # We want kernelcare to run.

    if ($::al_kcare::license) {
      # and we have a license, register it.

      exec { 'register-kernelcare':
        user    => 'root',
        command => "${::al_kcare::kcare_bin} --register ${::al_kcare::license} && echo 'REGDONE' > ${::al_kcare::register_file}",
        creates => $::al_kcare::register_file,
        require => Class['al_kcare::install']
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

  }

}
