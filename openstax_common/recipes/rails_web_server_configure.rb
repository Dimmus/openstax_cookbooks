if (node[:instance_role] == 'vagrant')
  directory "/var/lib/aws/opsworks" do
    recursive true
    action :create  
  end

  group "aws" do
    action :create
  end

  user "aws" do
    gid "aws"
    action :create
  end

  include_recipe "aws::opsworks_custom_layer_configure"
end

# The configure script freaks out if each depoloyed app doesn't have some 
# memcached values.

node[:deploy].each do |application, deploy|
  node.default[:deploy][application][:memcached][:host] = nil
  node.default[:deploy][application][:memcached][:port] = 11211
end

Chef::Log.info("restart command ***: #{node[:opsworks][:rails_stack][:restart_command]}")

include_recipe "rails::configure"