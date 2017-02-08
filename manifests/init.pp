#Class: puppet4
#
# Installs and manages Puppet 4 configuration and package
#
##Parameters
#
# @param [Integer] collection_version Version of Puppet Package Collection to be used for packages
# * `collection_version`  
# Version of Puppet Package Collection to be used for packages
#  
# @param [Boolean] repo_enabled Whether or not to enable the Puppet Collection repo in Yum
# * `repo_enabled`  
# Whether or not to enable the Puppet Collection repo in Yum. Disabled will still be installed but not used by default.
#  
# @param [String] package_version Version of Puppet All-in-One package to be installed
# * `package_version`  
# Values: 'latest', 'present', 'absent', or a specific version string
#  
# @param [Hash[String,Optional[String]]] config Hash of configuration parameters for the [main] block of puppet.conf
# * `config`  
# Hash of key/value Puppet configuration settings for the [main] block of puppet.conf
#  
##Variables
#
# This class includes the puppet4::user` class, which utilizes the following configuration variables
#
# * `user::config`  
# Hash of key/value Puppet configuration settings for the [user] block of puppet.conf
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
class puppet4(
  Integer $collection_version           = 1,
  Boolean $repo_enabled                 = true,
  String $package_version               = 'latest',
  Hash[String,Optional[String]] $config = {}, # common variables for all Puppet classes
) inherits puppet4::params {

  # Package collection repo
  if( $facts['os']['family'] == 'RedHat' ) {
    yumrepo { "puppetlabs-pc${collection_version}":
      ensure   => 'present',
      baseurl  => "http://yum.puppetlabs.com/el/7/PC${collection_version}/\$basearch",
      descr    => "Puppet Labs PC${collection_version} Repository EL ${facts['os']['release']['major']} - \$basearch",
      enabled  => $repo_enabled,
      gpgcheck => '1',
      gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    }
  }

  # Install the Puppet agent
  package { 'puppet-agent':
    ensure => $package_version,
  }

  # Write each agent configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    puppet4::inisetting { "main $setting":
      section => 'main',
      setting => $setting,
      value   => $value,
    }
  }

  # trigger that services can subscribe to
  exec { 'puppet4-configuration-has-changed':
    command     => '/bin/true',
    refreshonly => true,
  }

  # Call the user class to add the [user] block configs
  include puppet4::user
}
