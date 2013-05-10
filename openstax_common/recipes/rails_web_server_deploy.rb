if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_deploy"
end

include_recipe "deploy::rails"