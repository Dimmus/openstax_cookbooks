
node.normal["ebs"]["raids"]["blank?"] = true
node.normal["opsworks"]["instance"]["layers"] = "custom"

node.normal["opsworks"]["ruby_stack"] = 'ruby'
node.normal[:opsworks][:ruby_version] = '1.9.3'
node.normal[:ruby][:major_version] = '1.9'
node.normal[:ruby][:full_version] = '1.9.3'
node.normal[:ruby][:patch] = 'p392'
node.normal[:ruby][:pkgrelease] = '1'

Chef::Log.info("Purging NTP, Adding OpenNTP")

package "ntpd" do
  action :purge
end

package "openntpd" do
  action :purge
end

package "apparmor-utils" do
  action :install
end

execute "aa-complain `which ntpd`"

service "apparmor" do
  action :restart
end

package "openntpd" do
  action :install
end

include_recipe "opsworks_initial_setup"

# Skipping ssh_host_keys because it isn't applicable for Vagrant not to mention
# it doesn't have the required metadata.rb file.  Also skipping ssh_users since
# not relevant to Vagrant
#
# include_recipe "ssh_host_keys"
# include_recipe "ssh_users"

include_recipe "mysql::client"
include_recipe "dependencies"
include_recipe "ebs"
include_recipe "opsworks_ganglia::client"