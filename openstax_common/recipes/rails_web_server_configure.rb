if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_configure"
end

include_recipe "rails::configure"