#
# Cookbook Name:: rbenv
# Library:: resource_ext
#
# Author:: Jamie Winsor (<jwinsor@riotgames.com>)
# Copyright 2011, Riot Games
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

$:.push File.expand_path("../", __FILE__)
require 'chef/mixin/shell_out'
require 'chef/mixin/rbenv'
require 'chef/mixin/ruby_build'

class Chef
  module Rbenv
    module ResourceExt
      include Chef::Mixin::Rbenv
      include Chef::Mixin::RubyBuild
      include Chef::Mixin::ShellOut

      def latest_ruby_build_version
        if File.exists?("#{ruby_build_binary_path}")
          Proc.new do
            ruby_build_installed_verison.match(/#{node[:ruby_build][:version]}$/).nil?
          end
        else
          false
        end
      end
    end
  end
end

Chef::Resource::Bash.send(:include, Chef::Rbenv::ResourceExt)
