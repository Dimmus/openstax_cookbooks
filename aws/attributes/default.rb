node.default["aws"]["execute_user"] = "deploy"
node.default["aws"]["use_cli_mockup"] = false
node.default[:opsworks][:instance][:region] = 'NOT_SET'
node.default[:aws][:load_balancer_name] = 'NOT_SET'
node.default[:opsworks][:instance][:aws_instance_id] = 'NOT_SET'
node.normal["ebs"]["raids"]["blank?"] = true
node.normal["opsworks"]["instance"]["layers"] = "custom"
node.normal["opsworks"]["ruby_stack"] = 'ruby'
# node.normal["opsworks"]["rails_stack"]["name"] = 'nginx_unicorn'
# node.normal["opsworks"]["rails_stack"]["recipe"] = 'unicorn::rails'
# node.normal["opsworks"]["rails"]["ignore_bundler_groups"] = "development test"