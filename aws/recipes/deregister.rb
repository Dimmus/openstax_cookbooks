include_recipe "aws::cli"

Chef::Log.info("Will disconnect node (#{node[:opsworks][:instance][:aws_instance_id]}) from " + 
               "load balancer '#{node[:aws][:load_balancer_name]}' in region '#{node[:opsworks][:instance][:region]}'")

execute "register" do
  command "aws --region #{node[:opsworks][:instance][:region]} \
               elb deregister-instances-from-load-balancer \
               --load-balancer-name #{node[:aws][:load_balancer_name]} \
               --instances '[{\"instance_id\":\"#{node[:opsworks][:instance][:aws_instance_id]}\"}]'"
  user "#{node[:aws][:execute_user]}"
end