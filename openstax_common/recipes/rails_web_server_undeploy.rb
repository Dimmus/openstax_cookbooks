if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_undeploy"
end

include_recipe "deploy::rails-undeploy"