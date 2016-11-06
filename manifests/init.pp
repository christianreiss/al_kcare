# Class: al_kcare
# ===========================
#
# This module manages KernelCare
#
#  (https://www.cloudlinux.com/all-products/product-overview/kernelcare)
#
# on Servers by
#
#  - Importing the GPG RPM Respository Keys,
#  - Setting up the Repository itself,
#  - Installing KernelCare via above repo,
#  - Configures it to sane defaults,
#  - registers it with the License Servers,
#  - Export Monitoring objects,
#  - handles uninstalling, too.
#
#  The module is dortmant (disabled) by default, see setup below.
#
#
# Parameters
# ----------
#
# al_kcare::enabled: Set to true if you want the module to run.
# al_kcare::license: Your KernelCare License key. Can/Shold be
#           encrypted with eyaml.
# al_lcare::monitoring: enables the monitoring.
#
#
# Example
# --------
#
# @example
#    class { 'al_kcare':
#      enabled => true,
#      license => 'mylicensekey',
#    }
#
#
# Authors
# -------
#
# Christian Reiss <hosting@alpha-labs.net>
#
#
# Copyright
# ---------
#
# Copyright 2016 Christian Reiss.
#

class al_kcare (

  # Disabled by default.
  $enabled = false,

  # The License Key should be retrieved via encrypted hiera.
  $license = false,

  # If monitoring should be enabled.
  $monitoring = true

) inherits al_kcare::params {

#
#
#

#
# We can only run in specifiy virtual environments.
#
  case ($::virtual) {
    'physical': {
      # Physical Servers (bare metal) are no issue.
      $real_enabled = $enabled
    }

    'kvm': {
      # KVM run their own kernels, too.
      $real_enabled = $enabled
    }

    'openvzve': {
      # VZ Container are dependent on their Host Kernel, can't act.
      $real_enabled = false
    }

    'xen0': {
      # XenServer should not be touched by KernelCare.
      $real_enabled = false
    }

    'xenu': {
      # Xen Clients: Own Kernels, rock on!
      $real_enabled = $enabled
    }

    'xenhvm': {
      # Xen Clients: Own Kernels, rock on!
      $real_enabled = $enabled
    }

    default: {
      notify {"Your virtualisation environment ${::virtual} is unknown to me :/":}
      $real_enabled = false
    }
  }


  # Install.
  if ($::os['architecture'] == 'x86_64') {
    # Only run on 64 Bit machines.

    if ($::al_kcare::canrun) {
      # We only run on supported systems.
      include ::al_kcare::repo
      include ::al_kcare::install
      include ::al_kcare::register
      include ::al_kcare::monitoring
    }

  } else {

    notice {'You enabled KernelCare on a 32bit machine. This is not supported.':}

  }

}
