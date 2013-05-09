# There's some weird issue installing OpenNTP.  The machinations below get around it.
# Inspired mostly by https://bugs.launchpad.net/ubuntu/+source/openntpd/+bug/458061/

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
