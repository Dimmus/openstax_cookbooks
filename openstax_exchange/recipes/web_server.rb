Chef::Log.info("Starting web_server recipe")
Chef::Log.info("node[:instance_role] == #{node[:instance_role]}")

required_packages = [
  # sqlite3 needed by rails to precompile assets (needed by JS runtimes)
  "sqlite3", 
  "libsqlite3-dev",
  # To use passwords in user_account blocks
  "libshadow-ruby1.8"
]

required_packages.each do |required_package|
  package required_package do
    action [:upgrade]
  end
end

extra_firewall_rules = []

if (node[:instance_role] == "vagrant")
  extra_firewall_rules.concat([
    "vagrant" => {
      "port" => 3000
    }    
  ])
end

Chef::Log.debug "extra_firewall_rules: #{extra_firewall_rules.inspect}"

node.normal['openstax_exchange']['firewall']['rules'] = extra_firewall_rules


# node.normal['openstax_exchange']['firewall']['rules'] = [
#     "vagrant" => {
#       "port" => 3000
#     }    
#   ]

Chef::Log.debug "node.normal['openstax_exchange']['firewall']['rules']: #{node.normal['openstax_exchange']['firewall']['rules'].inspect}"

# directory "/srv/www" do
#   owner "root"
#   group (is_vagrant ? "root" : "webadmin")
#   mode "0775"
#   action :create
# end

node.normal['nginx']['firewall']['rules'] = [
  "http" => {
    "port" => 443,
    "protocol" => "tcp"
  }
]


Chef::Log.info("Finished web_server recipe")

include_recipe "openstax_exchange::web_server_firewall"
