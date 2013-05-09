firewall "ufw" do
  action :nothing
end


# open standard ssh port, enable firewall
firewall_rule "ssh" do
  port 22
  protocol :tcp
  action :allow
  notifies :enable, resources(:firewall => 'ufw') #"firewall[ufw]"
end

# open standard http port to tcp traffic only; insert as first rule
firewall_rule "http" do
  port 80
  protocol :tcp
  position 1
  action :allow
end

firewall_rule "https" do
  port 443
  protocol :tcp
  action :allow
end

if (node[:instance_role] == "vagrant")
  firewall_rule "vagrant" do
    port 3000
  end
end

execute "limit ssh retries" do
  command "ufw limit ssh/tcp"
  action :run
end