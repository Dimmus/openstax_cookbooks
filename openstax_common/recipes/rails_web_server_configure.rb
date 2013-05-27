if (node[:instance_role] == 'vagrant')
  directory "/var/lib/aws/opsworks" do
    recursive true
    action :create  
  end

  include_recipe "aws::opsworks_custom_layer_configure"
end

include_recipe "rails::configure"