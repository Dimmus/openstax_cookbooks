if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_deploy"
end

# Some opsworks code needs to think this is a rails-app layer
node.normal[:opsworks][:instance][:layers] = [node[:opsworks][:instance][:layers]].flatten.push('rails-app')

node[:deploy].each do |application, deploy|
  directory "#{deploy[:deploy_to]}/shared/cached-copy" do
    group deploy[:group]
    owner deploy[:user]
    mode 0770
    action :create
    recursive true
  end

  template "#{deploy[:deploy_to]}/shared/config/secret_settings.yml" do
    source 'secret_settings.yml.erb'
    mode '0660'
    variables(
      :secret_settings => deploy[:secret_settings]
    )

    only_if do
      File.exists?("#{deploy[:deploy_to]}") && File.exists?("#{deploy[:deploy_to]}/shared/config/")
    end
  end

  if (node[:generate_and_configure_ssl])
    ssl_directory = "#{node[:nginx][:dir]}/ssl"
    directory ssl_directory do
      action :create
      owner "root"
      group "root"
      mode 0600
    end

    cert_base_name = "#{deploy[:application]}.openstax.org"
    bash "Create SSL Certificate" do
      cwd ssl_directory
      code <<-EOH
      umask 077
      openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj "/C=US/ST=Texas/L=Houston/O=Rice University/CN=#{cert_base_name}" -keyout #{cert_base_name}.key -out #{cert_base_name}.crt
      cat #{cert_base_name}.key #{cert_base_name}.crt > #{cert_base_name}.pem
      EOH
      not_if { File.exists?("#{ssl_directory}/#{cert_base_name}.pem") }
    end
  end

end

include_recipe "deploy::rails"
