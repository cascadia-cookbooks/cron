#
# Cookbook:: cron
# Recipe:: default
# Description:: Manages system cron jobs
#

cron_service = node['cas_cron']['service']

# Install 'cron' packages
package node['cas_cron']['packages']

# Manage crontab templates
node['cas_cron']['jobs'].each do |name, job|
    template "Managing #{name} crontab file" do
        path "/etc/cron.d/#{name}"
        source 'crontab.erb'
        owner 'root'
        group 'root'
        mode 0644
        backup false
        action :create
        variables(
            job
        )
        notifies :restart, "service[#{cron_service}]", :delayed
    end
end

# Define 'cron_service' service
service cron_service do
    action :nothing
end
