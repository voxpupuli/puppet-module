require 'spec_helper'
describe 'puppet', type: 'class' do
  let :facts do
    {
      osfamily: 'RedHat',
      os: {
        'name' => 'CentOS',
        'family' => 'RedHat',
        'release' => {
          'major' => '7',
          'minor' => '4',
          'full'  => '7.4.1708'
        }
      }
    }
  end

  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('puppet') }
    it { is_expected.to contain_class('puppet::user') }
    it { is_expected.to contain_yumrepo('puppet5') }
  end

  context 'with manage_repo disabled' do
    let :params do
      { manage_repo: false }
    end

    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_class('puppet') }
    it { is_expected.not_to contain_yumrepo('puppet5') }
    it { is_expected.not_to contain_yumrepo('puppetlabs-pc1') }
  end

  %w[emerg crit alert err warning notice info debug verbose].each do |loglevel|
    context "with loglevel #{loglevel}" do
      let :params do
        { loglevel: loglevel }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('puppet') }
      # need config setting test
    end
  end

  context 'with invalid loglevel' do
    let :params do
      { loglevel: 'annoying' }
    end

    it { is_expected.to compile.and_raise_error(%r{Invalid value "annoying". Valid values are}) }
  end

  context 'with invalid repo_enabled' do
    let :params do
      { repo_enabled: 'junk' }
    end

    it { is_expected.to compile.and_raise_error(%r{expects a Boolean value, got String}) }
  end
end
