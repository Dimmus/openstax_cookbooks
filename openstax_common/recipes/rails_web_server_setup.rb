Chef::Log.info("Starting: openstax_commons::rails_web_server_setup")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

# # Define the following attributes to pin the version of Ruby installed
# # by Amazon's recipes.  This content should go into custom JSON on opsworks
# node.normal[:opsworks][:ruby_version] = '1.9.3'
# node.normal[:ruby][:major_version] = '1.9'
# node.normal[:ruby][:full_version] = '1.9.3'
# node.normal[:ruby][:patch] = 'p392'
# node.normal[:ruby][:pkgrelease] = '1'

include_recipe "apt"

# Since some recipes can actually bump their execution up to Chef compile time
# make sure the build tools do the same and run at compile time
node.normal['build_essential']['compiletime'] = true

package "libyaml-dev" do 
  action :install
end

if (node[:instance_role] == 'vagrant')

  # node["mysql"]["version"] = 5.1
  # node['mysql']['server_root_password'] = 'password'
  # node['mysql']['server_repl_password'] = 'password'
  # node['mysql']['server_debian_password'] = 'password'
  # include_recipe "mysql::server"

  include_recipe "aws::opsworks_custom_layer_setup"
  # include_recipe "apparmor"
  
  execute 'ln -sf /opt/vagrant_ruby/bin/chef-solo /usr/local/sbin/chef-solo' do
    action :run
  end

  execute 'install mysql-server manually because cookbook fails unexplainedly' do
    command <<-cmd
      echo mysql-server mysql-server/root_password password password | sudo debconf-set-selections;
      echo mysql-server mysql-server/root_password_again password password | sudo debconf-set-selections;
      apt-get -y install mysql-server
    cmd
    action :run
  end

  
end

# Standardize what /usr/bin/ruby points to (esp useful for unicorn scripts)
execute 'ln -sf `which ruby` /usr/bin/ruby' do
  action :run
end

include_recipe "build-essential"
include_recipe "firewall"

# node.normal["emacs"]["packages"] = ["emacs23-nox"]

include_recipe "emacs"

# The following code does work to install rbenv and rubies through it,
# however, it is much faster to use AWS's packaged binaries to get this 
# done.
#
# node.normal["rbenv"] = {
#   "rubies" => ["1.9.3-p392"],
#   "global" => "1.9.3-p392",
#   "install_pkgs" => []
# }
#
# include_recipe "ruby_build"
# include_recipe "rbenv::system"
#
# node.normal[:dependencies][:gem_binary] = 'gem'

required_packages = [
  # sqlite3 needed by rails to precompile assets (needed by JS runtimes)
  "sqlite3", 
  "libsqlite3-dev",
  # To use passwords in user_account blocks
  "libshadow-ruby1.8",
  "libxml2",
  "libxml2-dev",
  "libxslt-dev"
]

required_packages.each do |required_package|
  package required_package do
    action [:upgrade]
  end
end

# # Gets rid of an apache2 cookbook dependency from unicorn::rails
# node.normal["opsworks"]["skip_uninstall_of_other_rails_stack"] = true

include_recipe "unicorn::rails"
include_recipe "openstax_common::rails_web_server_firewall"

Chef::Log.info("Finished openstax_commons::rails_web_server_setup")

