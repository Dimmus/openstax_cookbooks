Chef::Log.info("Starting web_server recipe")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")


if (node[:instance_role] == 'vagrant')
  include_recipe "aws::opsworks_custom_layer_setup"
end

# include_recipe "dependencies"

include_recipe "apt"
include_recipe "build-essential"
include_recipe "firewall"
# include_recipe "nginx"

node.normal["emacs"]["packages"] = ["emacs23-nox"]

include_recipe "emacs"
include_recipe "ruby_build"

# node.normal["rbenv"]["rubies"] = ["1.9.3-p392"]
# node.normal["rbenv"]["global"] = "1.9.3-p392"
# node.normal

node.normal["rbenv"] = {
  "rubies" => ["1.9.3-p392"],
  "global" => "1.9.3-p392",
  "install_pkgs" => []
}

include_recipe "rbenv::system"

node.normal[:dependencies][:gem_binary] = 'gem'


required_packages = [
  # sqlite3 needed by rails to precompile assets (needed by JS runtimes)
  "sqlite3", 
  "libsqlite3-dev",
  # To use passwords in user_account blocks
  "libshadow-ruby1.8"
]

required_packages.each do |required_package|
  package required_package do
    action [:upgrade]
  end
end

# Gets rid of an apache2 cookbook dependency from unicorn::rails
node.normal["opsworks"]["skip_uninstall_of_other_rails_stack"] = true

include_recipe "unicorn::rails"

# directory "/srv/www" do
#   owner "root"
#   group (is_vagrant ? "root" : "webadmin")
#   mode "0775"
#   action :create
# end

include_recipe "openstax_exchange::web_server_firewall"

Chef::Log.info("Finished web_server recipe")

