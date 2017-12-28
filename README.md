# Puppet Configuration

[![Build Status](https://travis-ci.org/voxpupuli/puppet-module.svg?branch=master)](https://travis-ci.org/voxpupuli/puppet-module)

Manage Puppet 4/5+ apply, agent, certificate, and other Puppet tools configuration.

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

This module utilizes Hiera hierarchies to customize Puppet configuration for all three commands:
  * ```puppet apply```
  * ```puppet agent```
  * ```puppet cert```
  * ```puppet lookup```
  * ...etc

## Module Description

Configures Puppet 4/5+ agent, user tools, etc.

* Manages the Puppet yum repositories (if desired)
* Upgrades the `puppet-agent` package (if desired)
* Performs single-option configuration changes allowing local customizations to remain
* Strives to demonstrate Puppet best practices.

## Setup

### What puppet affects

* Yumrepo
  * Puppet package repository
* Packages
  * Puppet package
* Configuration Files
  * /etc/puppetlabs/puppet/puppet.conf

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
  * `puppet::package_name` = Override the default `puppet-agent` package name (for custom packages)
  * `puppet::manage_repo` = Boolean to manage the yum repo for the specified Puppet version
  * `puppet::repo_enabled` = Boolean to enable the repo for all Yum commands
  * `puppet::repos` = hash to override the public repo with a local mirror
  * `puppet::version` = 'latest', 'present', 'absent', or a specific version.
  * `puppet::config` = Hash of configuration parameters for the `[main]` section of puppet.conf
  * `puppet::user::config` = Hash of configuration parameters for the `[user]` section of puppet.conf
* Agent
  * `puppet::agent::status` = 'Running' (default) or 'Stopped'
  * `puppet::agent::enabled` = true (default) or false
  * `puppet::agent::config` = Hash of configuration parameters for the [agent] section of puppet.conf

## Reference

### Setup Requirements

* Classes
  * `puppet` - Maintains package repository, puppet package, and [main] block of puppet.conf
  * `puppet::user` - Maintains [user] block of puppet.conf
  * `puppet::agent` - Maintains [agent] block of puppet.conf and the `puppet` service

