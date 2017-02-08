#Class: puppet4::user
#
# Manages Puppet 4 [user] configuration for Puppet Apply
#
##Parameters
#
# @param [Hash[String,String]] config Hash of configuration parameters for the [user] block of puppet.conf
# * `config`  
# Hash of key/value Puppet configuration settings for the [user] block of puppet.conf
#  
# @example Hiera configuration
#    classes:
#      - puppet4
#  
#    puppet4::user::config:
#      loglevel: 'info'
#      logtarget: 'console'
#
##Authors
#
# @author Jo Rhett https://github.com/jorhett/puppet4-module/issues
# Jo Rhett, Net Consonance  
#   report issues to https://github.com/jorhett/puppet4-module/issues
#
##Copyright
#
# Copyright 2015, Net Consonance  
# All Rights Reserved
#
class puppet4::user(
  Hash[String,String] $config = {}, # common variables for all Puppet classes
) {
  # Write each user configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    puppet4::inisetting { "user ${setting}":
      section => 'user',
      setting => $setting,
      value   => $value,
    }
  }
}
