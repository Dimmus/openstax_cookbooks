
action :create do

  command_name = @new_resource.command_name
  run_list = @new_resource.run_list
  other_json = @new_resource.other_json
  solo_file_dir_name = "/var/lib/chef/configs/"
  json_file_name = "#{solo_file_dir_name}#{command_name}_solo.json"
  solo_file_name = "#{solo_file_dir_name}#{command_name}_solo.rb"
  
  directory solo_file_dir_name do
    owner "root"
    group "root"
    mode 00755
    recursive true
    action :create
  end

  template json_file_name do
    cookbook "openstax_common"
    source "solo_file_json.erb"
    mode '0744'
    variables({
      :run_list => run_list,
      :other_json => other_json
    })    
  end

  template solo_file_name do
    cookbook "openstax_common"
    source "solo_file.erb"
    mode '0744'
    variables({
      :cookbook_path => ::File.expand_path(::File.join(::File.dirname(__FILE__), '../..')),
      :json_file_name => json_file_name
    })
  end

  template "/usr/local/sbin/chef-solo_#{command_name}" do
    cookbook "openstax_common"
    source "chef_solo_file_command.erb"
    mode '0777'
    variables({
      :command_name => command_name
    })
  end
end