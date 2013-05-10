if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_shutdown"
end

include_recipe "nginx::stop"