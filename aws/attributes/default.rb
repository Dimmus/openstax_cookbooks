# Don't really need to set the load_balancer_name since OpsWorks is now 
# ELB aware, but leave just in case we want to call register or deregister
# manually
node.default["aws"]["execute_user"] = "deploy"
node.default["aws"]["use_cli_mockup"] = false
node.default[:aws][:load_balancer_name] = 'NOT_SET'

node.default[:opsworks][:instance][:region] = 'NOT_SET'
node.default[:opsworks][:instance][:aws_instance_id] = 'NOT_SET'

node.normal["opsworks"]["ruby_stack"] = 'ruby'

# node.normal["ebs"]["raids"]["blank?"] = true

if (node[:instance_role] == 'vagrant')
  node.normal[:opsworks][:instance][:hostname] = 'vagrant_hostname'
  node.normal["opsworks"]["instance"]["layers"] = ["vagrant-layer"]
  node.normal["opsworks"]["layers"]["vagrant-layer"]["name"] = "Vagrant Layer"
  node.normal["opsworks"]["layers"]["vagrant-layer"]["instances"] = {}

end


