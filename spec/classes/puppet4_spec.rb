require 'spec_helper'
describe 'puppet4', :type => 'class' do

  context 'with defaults for all parameters' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :os       => { 'family' => 'RedHat', 'release' => { 'major' => '7', 'minor' => '1' } },
      }
    end

    it do
      should contain_class('puppet4')
      should contain_class('puppet4::params')
    end

    it do
      should compile.with_all_deps
    end
  end

  [true,false].each do |repo_enabled|
    ['emerg','crit','alert','err','warning','notice','info','debug','verbose'].each do |loglevel|
      context "with #{repo_enabled} for repo_enabled, #{loglevel} for loglevel" do
        let :facts do
          {
            :osfamily => 'RedHat',
            :os       => { 'family' => 'RedHat', 'release' => { 'major' => '7', 'minor' => '1' } },
          }
        end

        let :params do
          {
            :repo_enabled => repo_enabled,
            :loglevel     => loglevel,
          }
        end

        it do
          should contain_class('puppet4')
          should contain_class('puppet4::params')
        end

        it do
          should compile.with_all_deps
        end
      end
    end
  end

  context 'with invalid loglevel' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :os       => { 'family' => 'RedHat', 'release' => { 'major' => '7', 'minor' => '1' } },
      }
    end

    let :params do
      {
        :loglevel => 'annoying'
      }
    end

    it do
      expect { should raise_error(Puppet::Error,/Invalid value "annoying". Valid values are/) }
    end
  end

  context 'with invalid repo_enabled' do
    let :facts do
      {
        :osfamily => 'RedHat',
        :os       => { 'family' => 'RedHat', 'release' => { 'major' => '7', 'minor' => '1' } },
      }
    end

    let :params do
      {
        :repo_enabled => 'EPEL'
      }
    end

    it do
      expect { should raise_error(Puppet::Error) }
    end
  end
end
