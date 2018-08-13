require 'beaker-rspec'

step 'Install Puppet on each host'
hosts.each do |host|
  on host, install_puppet(
    puppet_collection: 'pc1',
    #:version           => '4.3.1', # explicit version
  )
end

RSpec.configure do |c|
  # Find the module directory
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Enable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(
      source: module_root,
      module_name: 'puppet'
    )
    hosts.each do |host|
      # Install dependency modules
      on host, puppet('module', 'install', 'puppetlabs-stdlib'),
         acceptable_exit_codes: [0, 1]
      on host, puppet('module', 'install', 'puppetlabs-inifile'),
         acceptable_exit_codes: [0, 1]
    end
  end
end
