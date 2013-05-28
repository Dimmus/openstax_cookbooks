unless node[:opsworks][:skip_uninstall_of_other_rails_stack]
  include_recipe "apache2::uninstall"
end

include_recipe "nginx"
include_recipe "unicorn"