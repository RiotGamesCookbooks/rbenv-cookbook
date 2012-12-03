package "curl"
include_recipe "build-essential"
include_recipe "git"

case node[:platform]
when "redhat", "centos"
  package "openssl-devel"
  package "zlib-devel"
  package "readline-devel"
when "ubuntu", "debian"
  package "openssl"
  package "libssl-dev"
  package "libreadline-dev"
end

