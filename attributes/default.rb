node.default[:redis][:install_mode] = "manual"
node.default['redis']['localbin'] = "/usr/local/bin/redis-server"
node.default['redis']['url'] = "http://download.redis.io/redis-stable.tar.gz"
