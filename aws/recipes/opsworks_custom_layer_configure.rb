include_recipe "opsworks_ganglia::configure-client"
# include_recipe "ssh_users"
include_recipe "agent_version"
include_recipe "opsworks_stack_state_sync"