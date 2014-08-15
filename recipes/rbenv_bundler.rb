#
# Cookbook Name:: rbenv
# Recipe:: rbenv_bundler
#
# Author:: Guilhem Lettron <guilhem.lettron@optiflows.com>
#
# Copyright 2013, Optiflows
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

plugin_path = ::File.join(node[:rbenv][:root], "plugins", "rbenv-bundler")

git plugin_path do
  repository node[:rbenv_bundler][:git_repository]
  reference node[:rbenv_bundler][:git_revision]
  action :sync
  user node[:rbenv][:user]
  group node[:rbenv][:group]
end
