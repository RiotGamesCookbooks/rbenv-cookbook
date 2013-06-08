#
# Cookbook Name:: rbenv
# Recipe:: ruby_build
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

include_recipe "git"

Chef::Log.info("Installing ruby-build using #{node[:ruby_build][:install_method]}")
case node[:ruby_build][:install_method]
when "git"

  ruby_build_dir = "#{Chef::Config[:file_cache_path]}/ruby-build" 
  git ruby_build_dir do
    repository node[:ruby_build][:git_repository]
    reference node[:ruby_build][:git_revision]
    action :sync
  end
when "file"

  cookbook_file node[:ruby_build][:filename] do
    mode 0644
    cookbook node[:rbenv][:cookbook]
    path File.join(Chef::Config[:file_cache_path], node[:ruby_build][:filename])
  end

  ruby_build_file = node[:ruby_build][:filename]
  ruby_build_version = File.basename(ruby_build_file, ".tar.gz")
  ruby_build_dir = File.join(Chef::Config[:file_cache_path], ruby_build_version)

  extract_command = "tar xzf #{ruby_build_file}"
  Chef::Log.debug("Extracting ruby_build with command: #{extract_command}")
  bash "extract_ruby_build" do
    cwd Chef::Config[:file_cache_path]
    code extract_command
  end
else
  Chef::Log.error("Invalid install method for ruby-build: #{node[:ruby_build][:install_method]}")
  raise "Invalid install method: #{node[:ruby_build][:install_method]}"
end

bash "install_ruby_build" do
  cwd ruby_build_dir
  user "rbenv"
  group "rbenv"
  code <<-EOH
    ./install.sh
  EOH
  environment 'PREFIX' => node[:ruby_build][:prefix]
  not_if { desired_ruby_build_version? }
end
