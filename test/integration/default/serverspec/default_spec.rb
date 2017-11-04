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
end
