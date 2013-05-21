if (node[:instance_role] == 'vagrant')
  node.normal["aws"]["use_cli_mockup"] = true
  node.normal["aws"]["execute_user"] = 'vagrant'
end