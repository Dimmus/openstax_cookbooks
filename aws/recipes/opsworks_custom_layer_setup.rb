
node.normal["opsworks"]["ruby_stack"] = 'ruby'
node.normal["ebs"]["raids"]["blank?"] = true
node.normal["opsworks"]["instance"]["layers"] = "custom"



package "ntp" do
  action :purge
end

service "apparmor" do
  action :restart
end

package "openntpd" do
  action :install
end

# include_recipe "apt"

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