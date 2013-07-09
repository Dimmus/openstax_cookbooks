#
# Cookbook Name:: newrelic
# Recipe:: default
#
# Copyright 2012-2013, Escape Studios
#

if node['newrelic']
	include_recipe "newrelic::install"

	if node['newrelic']['server_monitoring'] && node['newrelic']['server_monitoring']['license']
		include_recipe "newrelic::server-monitor"
	end
end