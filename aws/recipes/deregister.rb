include_recipe "aws"

execute "deregister" do
  command <<-EOS \
    aws --region #{node[:opsworks][:instance][:region]} \
        elb deregister-instances-from-load-balancer \
        --load-balancer-name #{node[:aws][:load_balancer_name]} \
        --instances '{\"instance_id\":\"#{node[:opsworks][:instance][:aws_instance_id]}\"}'
  EOS
  user "deploy"
end