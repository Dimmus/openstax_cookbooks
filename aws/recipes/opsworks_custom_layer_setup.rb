
node.normal["ebs"]["raids"]["blank?"] = true
# node.normal["opsworks"]["instance"]["layers"] = "custom"
# node.normal["opsworks"]["ruby_stack"] = 'ruby'

# Get around some weird OpenNTP/NTP conflicts and issues
include_recipe "aws::openntpd_over_ntpd"

# Install aws cli
include_recipe "aws::cli"

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