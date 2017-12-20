# Puppet Configuration

[![Build Status](https://travis-ci.org/voxpupuli/puppet-module.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-module)

Manage Puppet 4 local apply, agent, and certificate configuration.

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with puppet](#setup)
    * [What puppet affects](#what-puppet-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with puppet](#beginning-with-puppet)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module utilizes Hiera hierarchies to customize Puppet 4 configuration for all three commands:
  * ```puppet apply```
  * ```puppet agent```
  * ```puppet cert```
  * ...etc

## Module Description

Installs and configures Puppet 4 package and optionally the agent daemon.
It strives to demonstrate Puppet 4 best practices.

## Setup

### What puppet affects

* Packages
  * Puppet Package Collection repository
  * Puppet 4 Package
  * Puppet Server Package (optional)
* Configuration Files
  * /etc/puppetlabs/puppet/puppet.conf
  * /etc/puppetlabs/server/webapp.conf

### Setup Requirements

Requires the `puppet-agent` package to be installed. (catch-22 yes I know)

### Beginning with puppet

Hiera configuration:

    classes:
      - puppet
      - puppet::agent (optional)

## Usage

Configuration values in Hiera (or supplied by an node terminus):

* Common
  * `puppet::pc_version` = Integer version of the Package Collection to use
  * `puppet::version` = 'latest', 'present', 'absent', or a specific version.
  * `puppepuppetig` = Hash of configuration parameters for the [main] section of puppet.conf
  * `puppet::user::config` = Hash of configuration parameters for the [user] section of puppet.conf
* Agent
  * `puppet::agent::status` = 'Running' (default) or 'Stopped'
  * `puppet::agent::enabled` = true (default) or false
  * `puppet::agent::config` = Hash of configuration parameters for the [agent] section of puppet.conf
* Master
  * `puppet::master::config` = Hash of configuration parameters for the [master] section of puppet.conf

## Reference

### Setup Requirements

* Classes
  * `puppet` - Maintains package repository, puppet package, and [main] block of puppet.conf
  * `puppet::user` - Maintains [user] block of puppet.conf
  * `puppet::agent` - Maintains [agent] block of puppet.conf and the `puppet` service
  * `puppet::server` - Maintains [master] block of puppet.conf and the `puppetserver` service

