Chef::Log.info("Starting openstax_exchange::rails_web_server_setup")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

# This delegates off to the common version of rails web server setup.
# Right here is where we could override node settings as needed

include_recipe "openstax_common::rails_web_server_setup"

if (node[:instance_role] == 'vagrant')

  node['mysql']['client']['packages'].each do |mysql_pack|
    resources("package[#{mysql_pack}]").run_action(:install)
  end
  chef_gem "mysql"

  mysql_connection_info = {:host => "localhost", :username => 'root', :password => 'password'}

  mysql_database 'dev_db' do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user 'dev_db_user' do
    connection mysql_connection_info
    password 'password'
    action :create
  end

  mysql_database_user 'dev_db_user' do
    connection mysql_connection_info
    database_name 'dev_db'
    privileges [:all]
    action :grant
  end
end

Chef::Log.info("Finished openstax_exchange::rails_web_server_setup")

