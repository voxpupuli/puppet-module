# Class: puppet::agent
# ====================
#
# Manages the Puppet agent service and configuration
#
# Parameters
# ----------
#
# @param [Enum['running','stopped']] status Whether Puppet client should run as a daemon
# * `status`  
#   Whether Puppet client should run as a daemon
#    values: running, stopped
#
# @param [Boolean] enabled Whether Puppet client should start at boot
# * `enabled`
#  Whether Puppet client should start at boot
#
# @param [Hash] config Hash of configuration settings for the [agent] block of puppet.conf
# * `config`
# Hash of key/value Puppet configuration settings for the [agent] block of puppet.conf
#
# Examples
# --------
# @example Hiera Sample
#    classes:
#      = puppet::agent
#
#    puppet::agent::status: 'running'
#    puppet::agent::enabled: true
#    puppet::agent::config:
#      server: 'puppet.example.com'
#
# Authors
# -------
# @author Jo Rhett, Net Consonance
# report issues at https://github.com/voxpupuli/puppet-module/issues
#
# Copyright
# ---------
# Copyright 2017, Vox Pupuli
# All Rights Reserved
#
class puppet::agent(
  # input parameters and default values for the class
  String $service_name               = 'puppet',
  Enum['running','stopped'] $status  = 'running',
  Boolean $enabled                   = true,
  Hash $config                       = {},
) inherits puppet {

  # Write each agent configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    puppet::inisetting { "agent ${setting}":
      section => 'agent',
      setting => $setting,
      value   => $value,
    }
  }

  # Manage the Puppet agent service
  service { $service_name:
    ensure    => $status,
    enable    => $enabled,
    subscribe => [Package[$puppet::package_name],Exec['puppet-configuration-has-changed']],
  }
}
