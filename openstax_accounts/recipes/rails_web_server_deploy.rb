Chef::Log.info("Instance role: #{node[:instance_role]}")

if (node[:instance_role] == 'vagrant')
  # Load attributes
  include_recipe "openstax_common"
  include_recipe "openstax_exchange"
  include_recipe "aws"
  include_recipe "nginx"  
end

include_recipe "openstax_common::rails_web_server_deploy"