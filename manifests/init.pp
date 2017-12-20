# Class: puppet
# =============
#
# Installs Puppet repo (optional), package, and manages Puppet configuration
#
# Parameters
# ----------
#
# @param [String] package_name Name of Puppet Agent package to be installed
# * `package_name`
# Default Value: 'puppet-agent'
#
# @param [String] version Version of Puppet Agent package to be installed
# * `version`
# Values: 'latest' (default), 'present', 'absent', or a specific version string
#
# @param [Boolean] manage_repo Whether or not to create a yumrepo resource for the Puppet repo
# * `manage_repo`
# Default Value: true
#
# @param [Boolean] repo_enabled Whether or not to enable the Puppet repo in Yum
# * `repo_enabled`
# Whether or not to enable the Puppet repo in Yum. Disabled will still allow agent installation, but will not used by other yum commands.
#
# @param [Hash] repos Hash of repositories for Puppet packages
# * `repos`
# Hash of Yum repositories in yumrepo resource format. Deep merged with defaults in module can be overriden in environment
#
# @param [Hash[String,Optional[String]]] config Hash of configuration parameters for the [main] block of puppet.conf
# * `config`
# Hash of key/value Puppet configuration settings for the [main] block of puppet.conf
#
# Examples
# --------
# @example Hiera configuration
#    classes:
#      - puppet
#
#    puppet::version: 'latest'
#    puppet::config:
#      loglevel: 'info'
#      logtarget: 'syslog'
#
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
class puppet(
  # Default values in data/defaults.yaml
  String $package_name,
  String $version,
  Boolean $manage_repo,
  Boolean $repo_enabled,
  Hash $repos,
  Hash[String,Optional[String]] $config,
) {

  # Alternative is to use puppet/yum and add the appropriate repo to `yum::managed_repos`
  if $manage_repo {
    # Determine which repository to install
    $repo_name = $version ? {
      /^1/    => 'puppetlabs-pc1', # Puppet 4 == Pupet agent 1...
      /^4/    => 'puppetlabs-pc1', # Puppet 4
      default => 'puppet5',        # default to Puppet 5
    }

    # Create the repo compatible with yumrepo resource management
    yumrepo { $repos[$repo_name]['name']:
      ensure   => 'present',
      enabled  => $repo_enabled,
      baseurl  => $repos[$repo_name]['baseurl'],
      descr    => $repos[$repo_name]['descr'],
      gpgcheck => $repos[$repo_name]['gpgcheck'],
      gpgkey   => $repos[$repo_name]['gpgkey'],
    }
  }

  # Install the Puppet agent
  package { $package_name:
    ensure => $version,
  }

  # Write each main configuration option to the puppet.conf file
  $config.each |$setting,$value| {
    puppet::inisetting { "main ${setting}":
      section => 'main',
      setting => $setting,
      value   => $value,
    }
  }

  # A trigger that services can subscribe to
  exec { 'puppet-configuration-has-changed':
    command     => '/bin/true',
    refreshonly => true,
  }

  # Call the user class to add the [user] block configs
  include puppet::user
}
