#
# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
node.default[:redis][:install_mode] = "manual"

case node[:redis][:install_mode]
when "manual"
  include_recipe "redis::manual_install"

else
  # install from package
  package "epel-release"
  package "redis"
  service "redis" do
    action [:enable, :start]
  end
end
