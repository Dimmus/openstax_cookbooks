Chef::Log.info("Starting web_server recipe")

if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_setup"
end

include_recipe "openstax_exchange::web_server_setup"