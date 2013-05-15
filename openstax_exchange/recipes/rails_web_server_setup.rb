Chef::Log.info("Starting openstax_exchange::rails_web_server_setup")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

# This delegates off to the common version of rails web server setup.
# Right here is where we could override node settings as needed

include_recipe "openstax_common::rails_web_server_setup"

if (node[:instance_role] == 'vagrant')
  node.normal["aws"]["use_cli_mockup"] = true
  node.normal["aws"]["execute_user"] = 'vagrant'
end

node.normal["aws"]["load_balancer_name"] = 'exchange'
include_recipe 'aws::register'


openstax_common_solo_file 'deploy' do
  run_list 'openstax_exchange::rails_web_server_deploy'
end

Chef::Log.info("Finished openstax_exchange::rails_web_server_setup")

