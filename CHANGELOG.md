# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

##2017-12-20 - Release 0.2.0

### Added
- Support for Puppet5
- Hiera data-in-module

### Changed
- Renamed module from *puppet4* to *puppet*
- Renamed repository from *puppet4* to *puppet-module*
- Use yumrepo resource instead of release package

### Removed
- params subclass

##2017-02-07 - Release 0.1.0

First import of the module

### Features
- Manages the puppet collection repo
- Manages the puppet agent package and service
- Manages the puppet configuration files

### Todo
- add acceptance tests
- add module_sync
