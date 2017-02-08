require 'spec_helper_acceptance'

describe 'puppet::agent class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should install with no errors using default values' do
      puppetagent = <<-EOS
        class { 'puppet::agent': }
      EOS

      # Run twice to test idempotency
      expect( apply_manifest( puppetagent ).exit_code ).to_not eq(1)
      expect( apply_manifest( puppetagent ).exit_code ).to eq(0)
    end

    describe package('puppet-agent') do
      it { should be_installed }
    end

    describe file('/etc/puppetlabs/puppet/puppet.conf') do
      it { should be_a_file }
    end

    describe service('puppet') do
      it { should be_enabled }
    end

  end
end

