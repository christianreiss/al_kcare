class al_kcare::monitoring {

  if ($::al_kcare::real_enabled == true) {
    # We only act if the system is marked as enabled.

    if ($::al_kcare::monitoring == true) {
      # And only if monitoring is requested.

      #
      # This only acts on my servers to avoid conflicts.
      #
      if (! $::icinga::client::nrpe_pluginpath ) {
        file { "${::al_kcare::nrpe_pluginpath}/contrib.d":
          ensure => directory,
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        }

        #
        # Monitoring file for active check
        #
        file { "${::al_kcare::nrpe_pluginpath}/contrib.d/check_kcare.sh":
          ensure  => file,
          owner   => root,
          group   => root,
          mode    => '0755',
          content => template('al_kcare/check_kcare.sh.erb'),
          require => File["${::al_kcare::nrpe_pluginpath}/contrib.d"],
        }
      } else {
        file { "${::al_kcare::nrpe_pluginpath}/contrib.d/check_kcare.sh":
          ensure  => file,
          owner   => root,
          group   => root,
          mode    => '0755',
          content => template('al_kcare/check_kcare.sh.erb'),
        }
      }

      #
      # This sets up the monitoring job itself.
      #
      @@nagios_service { "${::fqdn}-kcare-local":
        ensure                 => present,
        check_command          => 'check_nrpe!check_kcare',
        display_name           => 'kernelcare',
        service_description    => 'kernelcare',
        check_interval         => '60',
        check_period           => '24x7',
        contact_groups         => $::al_kcare::contactgroup,
        host_name              => $::fqdn,
        initial_state          => 'o',
        max_check_attempts     => '3',
        flap_detection_enabled => '0',
        notification_interval  => '0',
        notification_options   => 'c,r',
        process_perf_data      => '0',
        notification_period    => 'daytime',
        notifications_enabled  => $::al_kcare::checks::notifications,
        register               => '1',
        retry_interval         => '5',
      }
    }

  } else {

    # We want it removed, cleanup.

    file { "${::al_kcare::nrpe_pluginpath}/contrib.d/check_kcare.sh":
      ensure  => absent,
    }

    @@nagios_service { "${::fqdn}-kcare-local":
      ensure                 => absent,
    }

  }
}
