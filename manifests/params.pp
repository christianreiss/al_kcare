class al_kcare::params {

  #
  # Manage per-OS settings.
  #
  case ($::operatingsystem) {

    'Fedora': {
      $kcare_bin = '/bin/kcarectl'
      $nrpe_pluginpath   = '/usr/lib64/nagios/plugins'
    }

    'CloudLinux': {
      $register_file   = '/etc/sysconfig/kcare/registered'
      $nrpe_pluginpath = '/usr/lib64/nagios/plugins'
      case ($::operatingsystemmajrelease) {
        '5': {
          $kcare_bin ='/usr/bin/kcarectl'
          $canrun    = true
        }
        '6': {
          $kcare_bin='/usr/bin/kcarectl'
          $canrun = true
        }
        '7': {
          $kcare_bin='/bin/kcarectl'
          $canrun = true
        }
        default: {
          fail ("Operatingsystem ${::operatingsystem} Version ${::operatingsystemmajrelease} not known to al_kcare::params.")
        }
      }
    }

    'CentOS': {
      $register_file   = '/etc/sysconfig/kcare/registered'
      $nrpe_pluginpath = '/usr/lib64/nagios/plugins'
      case ($::operatingsystemmajrelease) {
        '5': {
          $kcare_bin='/usr/bin/kcarectl'
          $canrun = true
        }
        '6': {
          $kcare_bin='/usr/bin/kcarectl'
          $canrun = true
        }
        '7': {
          $kcare_bin='/bin/kcarectl'
          $canrun = true
        }
        default: {
          fail ("Operatingsystem ${::operatingsystem} Version ${::operatingsystemmajrelease} not known to al_kcare::params.")
        }
      }
    }

    'XenServer': {
      notice {'You enabled KernelCare on a XenServer host. This is not supported; disabling.': }
      $canrun = false
    }

    default: {
      fail ("Operatingsystem ${::operatingsystem} not known to al_kcare::params.")
      $canrun = false
    }

  }

}
