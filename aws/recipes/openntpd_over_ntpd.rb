Chef::Log.info("Purging NTP, Adding OpenNTP")

package "ntpd" do
  action :purge
end

package "openntpd" do
  action :purge
end

package "apparmor-utils" do
  action :install
end

execute "aa-complain `which ntpd`"

service "apparmor" do
  action :restart
end

package "openntpd" do
  action :install
end
