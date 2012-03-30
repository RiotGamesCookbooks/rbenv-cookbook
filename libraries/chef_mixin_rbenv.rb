#
# Cookbook Name:: rbenv
# Library:: mixin_rbenv
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
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

require 'chef/mixin/shell_out'

class Chef
  module Mixin
    module Rbenv
      include Chef::Mixin::ShellOut

      def rbenv_command(cmd, options = {})
        unless rbenv_installed?
          Chef::Log.error("rbenv is not yet installed. Unable to run " +
                          "rbenv_command:`#{cmd}`. Are you trying to use " +
                          "`rbenv_command` at the top level of your recipe? " +
                          "This is known to cause this error")
          raise "rbenv not installed. Can't run rbenv_command"
        end

        default_options = {
          :user => 'rbenv', 
          :group => 'rbenv', 
          :env => { 
            'RBENV_ROOT' => rbenv_root
          },
          :timeout => 3600
        }
        shell_out("#{rbenv_binary_path} #{cmd}", Chef::Mixin::DeepMerge.deep_merge!(options, default_options))
      end

      def rbenv_installed?
        out = shell_out("ls #{rbenv_binary_path}")
        out.exitstatus == 0
      end

      def ruby_version_installed?(version)
        out = rbenv_command("prefix", :env => { 'RBENV_VERSION' => version })
        out.exitstatus == 0
      end

      def gem_binary_path_for(version)
        "#{rbenv_prefix_for(version)}/bin/gem"
      end

      def rbenv_prefix_for(version)
        out = rbenv_command("prefix", :env => { 'RBENV_VERSION' => version })

        unless out.exitstatus == 0
          raise Chef::Exceptions::ShellCommandFailed, "\n" + out.format_for_exception
        end

        prefix = out.stdout.chomp
      end

      def rbenv_root
        "#{node[:rbenv][:system_prefix]}/rbenv"
      end

      private

        def rbenv_binary_path
          "#{rbenv_root}/bin/rbenv"
        end
    end
  end
end
