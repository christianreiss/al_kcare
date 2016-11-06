# al_kcare

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with al_kcare](#setup)
    * [What al_kcare affects](#what-al_kcare-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with al_kcare](#beginning-with-al_kcare)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Support](#support)

## Description

This module manages KernelCare

    (https://www.cloudlinux.com/all-products/product-overview/kernelcare)

on Servers by

  - Importing the GPG RPM Respository Keys,
  - Setting up the Repository itself,
  - Installing KernelCare via above repo,
  - Configures it to sane defaults,
  - registers it with the License Servers,
  - Export Monitoring objects,
  - handles uninstalling, too.

The module is dortmant (disabled) by default, see setup below.

## Setup

### What al_kcare affects **OPTIONAL**

The Module itself will only get KernelCare running, handling of patches and
modifying the servers if part of the software. So it will affect your Kernel
eventually, but that is your aim, anyway.

Besides that there are no changes to your system.

### Setup Requirements **OPTIONAL**

There are no dependencies on other modules; this module stands on its own.
The only exception is monitoring; this module only exports the nagios
puppet types which needs to be realized by a(ny) monitoring module.

So far KernelCare Module works with:

  - Centos 5
  - Centos 6
  - Centos 7
  - CloudLinux 5
  - CloudLinux 6
  - CloudLinux 7

More Operating Systems will be added soon. Next stop: Debian.

### Beginning with al_kcare

You need a running Puppet infrastructure, which should be obvious as this is
a puppet module. To install and get it running simply place this module in
your module folder and add the module to your Servers. Then, via hiera add
these overrides:

   al_kcare::enabled: true

 which will enable kcare for the server. If you have a license key, add it:

   al_kcare::license: 'yourkeyhere'

If you do not supply a key the system will switch to trial mode (or IP based
license).

## Usage

There is no "Usage" besides installing. The rest is fully automated.

## Limitations

KernelCare can handle/manage a lot of Operating Systems. This module, as of
writing this readme only handles the above operating Systems. This is a limitaiton
that will be lifted.

## Development

If you like to contribute, feel free to send pull requests via github.

## Support

If you need support, contact me via

  hosting@alpha-labs.net

The issues tab in Github should only be used for... issues.


Enjoy the module!
-Christian Reiss.
