include_recipe "python::package"
include_recipe "python::pip"

execute "install awscli manually because AWS chef is ancient" do
  command "pip install awscli"
end

# python_pip "awscli" do
#   action :install
# end

if (node["aws"]["use_cli_mockup"]) 
  Chef::Log.info("Masking real aws cli program with mockup")
  template '/usr/local/sbin/aws' do
    source 'aws_mockup.sh'
    mode '0777'
  end
end