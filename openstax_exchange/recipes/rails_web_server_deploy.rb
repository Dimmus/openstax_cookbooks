if (node[:instance_role] == 'vagrant')
  # Load attributes
  include_recipe "aws"
  include_recipe "openstax_common"
  include_recipe "openstax_exchange"
end

include_recipe "openstax_common::rails_web_server_deploy"