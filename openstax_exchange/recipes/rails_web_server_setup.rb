Chef::Log.info("Starting openstax_exchange::rails_web_server_setup")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

# This delegates off to the common version of rails web server setup.
# Right here is where we could override node settings as needed

include_recipe "openstax_common::rails_web_server_setup"

Chef::Log.info("Finished openstax_exchange::rails_web_server_setup")

