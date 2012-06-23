#
# Cookbook Name:: rbenv
# Definition:: rbenv_installation
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

define :rbenv_installation,
       :type                => [:system],
       :git_repository      => 'git://github.com/sstephenson/rbenv.git',
       :git_revision        => 'master',
       :rbenv_root          => nil,
       :ruby_build_bin_path => nil do

  params[:type] ||= params[:name]
  params[:rbenv_root] ||= "#{node[:rbenv][:install_prefix]}/rbenv"
  params[:ruby_build_bin_path] ||= "#{node[:ruby_build][:prefix]}/bin"

  package "curl"

  case node[:platform]
  when "redhat"
    package "openssl-devel"
    package "zlib-devel"
  when "ubuntu", "debian"
    package "build-essential"
    package "openssl"
    package "libssl-dev"
    package "libreadline-dev"
  end

  include_recipe "git"
  include_recipe "rbenv::ruby_build"

  group "rbenv" do
    members node[:rbenv][:group_users] if node[:rbenv][:group_users]
  end

  user "rbenv" do
    shell "/bin/bash"
    group "rbenv"
    supports :manage_home => true
  end

  directory params[:rbenv_root] do
    owner "rbenv"
    group "rbenv"
    mode "0775"
  end

  git params[:rbenv_root] do
    repository params[:git_repository]
    reference params[:git_revision]
    user "rbenv"
    group "rbenv"
    action :sync
  end

  template "/etc/profile.d/rbenv.sh" do
    source "rbenv.sh.erb"
    mode "0644"
    variables(
      :rbenv_root => params[:rbenv_root],
      :ruby_build_bin_path => params[:ruby_build_bin_path]
    )
    notifies :run, "bash[source_rbenv_sh]", :immediately
  end

  bash "source_rbenv_sh" do
    code "source /etc/profile.d/rbenv.sh"
  end

  bash "set_permissions_on_rbenv_root" do
    code <<-EOH
      chown -R rbenv:rbenv #{params[:rbenv_root]}
      chmod -R 775 #{params[:rbenv_root]}
    EOH
  end
end
