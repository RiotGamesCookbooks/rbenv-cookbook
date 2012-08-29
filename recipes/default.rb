#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2011-2012, Riot Games
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set[:rbenv][:root]          = "#{node[:rbenv][:install_prefix]}/rbenv"
node.set[:ruby_build][:bin_path] = "#{node[:ruby_build][:prefix]}/bin"

package "curl"

case node[:platform]
when "redhat", "centos"
  package "openssl-devel"
  package "zlib-devel"
  package "readline-devel"
when "ubuntu", "debian"
  package "build-essential"
  package "openssl"
  package "libssl-dev"
  package "libreadline-dev"
end

include_recipe "git"

group "rbenv" do
  members node[:rbenv][:group_users] if node[:rbenv][:group_users]
end

user "rbenv" do
  shell "/bin/bash"
  group "rbenv"
  supports :manage_home => true
end

directory node[:rbenv][:root] do
  owner "rbenv"
  group "rbenv"
  mode "0775"
end

git node[:rbenv][:root] do
  repository node[:rbenv][:git_repository]
  reference node[:rbenv][:git_revision]
  user "rbenv"
  group "rbenv"
  action :sync

  notifies :create, "template[/etc/profile.d/rbenv.sh]", :immediately
end

template "/etc/profile.d/rbenv.sh" do
  source "rbenv.sh.erb"
  mode "0644"
  variables(
    :rbenv_root => node[:rbenv][:root],
    :ruby_build_bin_path => node[:ruby_build][:bin_path]
  )

  notifies :create, "ruby_block[initialize_rbenv]", :immediately
end

ruby_block "initialize_rbenv" do
  block do
    ENV['RBENV_ROOT'] = node[:rbenv][:root]
    ENV['PATH'] = "#{node[:rbenv][:root]}/bin:#{node[:ruby_build][:bin_path]}:#{ENV['PATH']}"
  end

  action :nothing
end
