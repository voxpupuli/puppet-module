# Class: puppet::user
# ===================
#
# Manages Puppet `[user]` configuration for Puppet `apply`, `lookup`, `cert`, etc.
#
# Parameters
# ----------
#
# @param [Hash[String,String]] config Hash of configuration parameters for the [user] block of puppet.conf
# * `config`
# Hash of key/value Puppet configuration settings for the [user] block of puppet.conf
#
# Examples
# --------
# @example Hiera configuration
#    classes:
#      - 'puppet::user'
#
#    puppet::user::config:
#      loglevel: 'info'
#      logtarget: 'console'
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
class puppet::user (
  Hash[String,String] $config = {},
) {
  # Write each user configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    puppet::inisetting { "user ${setting}":
      section => 'user',
      setting => $setting,
      value   => $value,
    }
  }
}
