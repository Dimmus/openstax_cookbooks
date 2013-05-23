Chef::Log.info("Starting openstax_exchange::rails_web_server_setup")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

# This delegates off to the common version of rails web server setup.
# Right here is where we could override node settings as needed

include_recipe "openstax_common::rails_web_server_setup"

if (node[:instance_role] == 'vagrant')


node['mysql']['client']['packages'].each do |mysql_pack|
  resources("package[#{mysql_pack}]").run_action(:install)
end
  # %w(mysql-client libmysqlclient-dev).each do |mysql_pack|
  #   resources("package[#{mysql_pack}]").run_action(:install)
  # end
  include_recipe "build-essential"
  chef_gem "mysql"

  mysql_connection_info = {:host => "localhost", :username => 'root', :password => 'password'}

  mysql_database 'production' do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user 'production_user' do
    connection mysql_connection_info
    password 'password'
    action :create
  end

  mysql_database_user 'production_user' do
    connection mysql_connection_info
    database_name 'production'
    privileges [:all]
    action :grant
  end
end

if (node[:instance_role] == 'vagrant')
  openstax_common_solo_file 'deploy' do
    command_name 'deploy'
    run_list 'openstax_exchange::rails_web_server_deploy'
    other_json ({
      :exchange => {
        # :user => "deploy",
        # :group => "www-data",
        # :home => '/home/deploy',
        :application => "exchange", 
        :application_type => "rails", 
        :auto_bundle_on_deploy => true, 
        :database => {
          :database => "exchange", 
          :host => nil, 
          :password => nil, 
          :reconnect => true, 
          :username => "root"
        }, 
        # :deploy_to => "/srv/www/exchange", 
        :document_root => "public", 
        :domains => [
          :"exchange.openstax.org", 
          :"exchange"
        ], 
        # :memcached => {
        #   :host => nil, 
        #   :port => 11211
        # }, 
        :migrate => false, 
        # :mounted_at => nil, 
        :rails_env => "production", 
        # :restart_command => nil, 
        :delete_cached_copy => false,
        :scm => {
          :password => nil, 
          :repository => "git://github.com/openstax/exchange.git", 
          :revision => nil, 
          :scm_type => "git", 
          :ssh_key => "", 
          :user => "deploy",
          :group => 'www-data'
        }, 
        :sleep_before_restart => 0, 
        :ssl_certificate => nil, 
        :ssl_certificate_ca => nil, 
        :ssl_certificate_key => nil, 
        :ssl_support => false, 
        :symlink_before_migrate => {
          :'config/database.yml' => "config/database.yml", 
          :'config/memcached.yml' => "config/memcached.yml"
        }, 
        :symlinks => {
          :log => "log", 
          :pids => "tmp/pids", 
          :system => "public/system"
        },
        :ignore_bundler_groups => ["development" ,"test"]
      }
    })
  end
end

Chef::Log.info("Finished openstax_exchange::rails_web_server_setup")

