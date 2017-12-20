require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|
  # supply tests with a possibility to test for the future parser
  config.ordering = 'manifest' # Puppet 5 standard
  config.stringify_facts = false # Puppet 5 standard

  # provide a coverage report
  config.after(:suite) do
    RSpec::Puppet::Coverage.report!
  end
end

if ENV['DEBUG']
  Puppet::Util::Log.level = :debug
  Puppet::Util::Log.newdestination(:console)
end
