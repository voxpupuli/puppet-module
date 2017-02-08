# Puppet4 Configuration

[![Build Status](https://travis-ci.org/voxpupuli/puppet4.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet4)

Manage Puppet 4 local apply, agent, certificate, and Puppet Server configuration.

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

This is a module written to manage Puppet 4 configuration, agent, master, and Puppet Server.

## Module Description

Installs and configures Puppet 4, and optionally, the agent, master, and Puppet Server
daemons.

This a demonstration module utilizing Puppet 4 features and demonstrating Puppet best practices.

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

Requires the Puppet 4 package to be installed. (catch-22 yes I know)
I may attempt in the future to test a way to upgrade from Puppet 3 but that is
has not been tested.

### Beginning with puppet

Hiera configuration:

    classes:
      - puppet4
      - puppet4::agent (optional)

## Usage

Configuration values in Hiera (or supplied by an node terminus):

* Common
  * `puppet4::pc_version` = Integer version of the Package Collection to use
  * `puppet4::version` = 'latest', 'present', 'absent', or a specific version.
  * `puppet4::config` = Hash of configuration parameters for the [main] section of puppet.conf
  * `puppet4::user::config` = Hash of configuration parameters for the [user] section of puppet.conf
* Agent
  * `puppet4::agent::status` = 'Running' (default) or 'Stopped'
  * `puppet4::agent::enabled` = true (default) or false
  * `puppet4::agent::config` = Hash of configuration parameters for the [agent] section of puppet.conf
* Server
  * `puppet4::server::status` = 'Running' (default) or 'Stopped'
  * `puppet4::server::enabled` = true (default) or false
  * `puppet4::server::config` = Hash of configuration parameters for the [master] section of puppet.conf

## Reference

### Setup Requirements

* Classes
  * puppet4 - Maintains package repository, puppet package, and [main] block of puppet.conf
  * puppet4::user - Maintains [user] block of puppet.conf
  * puppet4::agent - Maintains [agent] block of puppet.conf and the `puppet` service
  * puppet4::server - Maintains [master] block of puppet.conf and the `puppetserver` service

## Limitations

Uses data types and validateion features of Puppet 4 therefore only Puppet 4 is supported.
May possibly work with Puppet 3.7 or higher with the 'future' parser but is not tested as such.

## Development


