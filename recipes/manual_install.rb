#
# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

## another way of installing redis by downloading tarball


#node.default['redis']['url'] = "http://download.redis.io/redis-stable.tar.gz"
package_name = ::File.basename(node.default['redis']['url'])
package_local_path = "#{Chef::Config['file_cache_path']}/#{package_name}"
redis_local = node.default['redis']['localbin']

package 'gcc'
package 'tcl'

remote_file package_local_path do
  source 'http://download.redis.io/redis-stable.tar.gz'
  action :create
  not_if {File.exists?(package_local_path)}
end

#tar xvzf redis-stable.tar.gz
execute "untar redis-stable.tar.gz" do
  cwd "#{Chef::Config[:file_cache_path]}"
  command "tar xvzf #{package_name}"

end

#cd redis-stable
#make
execute "make redis" do
  cwd "#{Chef::Config[:file_cache_path]}/redis-stable"
  #command "touch make_all"
  command "make all >/tmp/make.log 2>&1"
  not_if { File.exists?(redis_local)}
end

execute "make install redis" do
  cwd "#{Chef::Config[:file_cache_path]}/redis-stable"
  command "make install"
  not_if { File.exists?(redis_local)}
end

execute "running redis in the background" do
  command "/usr/local/bin/redis-server --daemonize yes"
  only_if { File.exists?(redis_local)}
end
