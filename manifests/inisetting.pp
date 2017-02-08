#Type: puppet4::inisetting
#
# Installs and manages Puppet 4 configuration setting
#
##Parameters
#
# @param [Enum['main','user','agent','master']] section Section of the configuration file
# * `section`  
# Section of the configuration file. One of 'main','user','agent','master'
#
# @param [String] setting Name of the configuration setting
# * `setting`  
# Name of the configuration setting
#  
# @param [String] value Value for the setting
# * `value`  
# Values for the setting
#  
# @example Hiera configuration
#    classes:
#      - puppet4
#  
#    puppet4::version: 'latest'
#    puppet4::config:
#      loglevel: 'info'
#      logtarget: 'syslog'
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
define puppet4::inisetting(
  Enum['main','user','agent','master'] $section = 'main',
  String $setting,
  Optional[String] $value = undef,
) {

  # Remove values not defined or empty
  $is_present = $value ? {
    undef   => 'absent',
    ""      => 'absent',
    default => 'present',
  }

  # Write the agent configuration option to the puppet.conf file
  ini_setting { $title:
    ensure  => $is_present,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    section => $section,
    setting => $setting,
    value   => $value,
    require => Package['puppet-agent'],
    notify  => Exec['puppet4-configuration-has-changed'],
  }
}
