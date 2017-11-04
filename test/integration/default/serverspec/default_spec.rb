require 'spec_helper'

describe 'cas_cron::default' do
    # Case for platform family
    case os[:family]
    when 'debian', 'ubuntu'
        cron_package = 'cron'
        cron_service = 'cron'
    when 'redhat'
        cron_package = 'cronie'
        cron_service = 'crond'
    end

    describe package(cron_package) do
        it { should be_installed }
    end

    describe service(cron_service) do
        it { should be_enabled }
        it { should be_running }
    end

    describe file('/etc/cron.d/test1') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode '644' }
        its(:content) { should include 'HOME=/var/www/html/' }
        its(:content) { should include 'PATH=/sbin:/bin:/usr/sbin:/usr/bin' }
        its(:content) { should include '@weekly root /bin/true' }
    end

    describe file('/etc/cron.d/test2') do
        it { should exist }
        it { should be_owned_by 'root' }
        it { should be_grouped_into 'root' }
        it { should be_mode '644' }
        its(:content) { should include '# This is a test comment' }
        its(:content) { should include '1 2 3 4 * root /bin/false' }
    end
end
