if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_deploy"
end

node.normal[:opsworks][:instance][:layers] = [node[:opsworks][:instance][:layers]].flatten.push('rails-app')

node[:deploy].each do |application, deploy|
  directory "#{deploy[:deploy_to]}/shared/cached-copy" do
    group deploy[:group]
    owner deploy[:user]
    mode 0770
    action :create
    recursive true
  end
end

include_recipe "deploy::rails"