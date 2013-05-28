include_recipe "python::package"
include_recipe "python::pip"

execute "install awscli manually because AWS chef is ancient" do
  command "pip install -Iv https://github.com/aws/aws-cli/archive/0.10.1.tar.gz"
  # Installing the latest with the below ran into some issues, better to pin a version
  # command "pip install awscli"
end

if (node["aws"]["use_cli_mockup"]) 
  Chef::Log.info("Masking real aws cli program with mockup")
  template '/usr/local/sbin/aws' do
    source 'aws_mockup.sh'
    mode '0777'
  end
end