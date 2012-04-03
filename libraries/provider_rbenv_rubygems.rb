#
# Cookbook Name:: rbenv
# Library:: provider_rbenv_rubygems
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

class Chef
  module Mixin
    module Rbenv
      # stub to satisfy RbenvRubygems (library load order not guaranteed)
    end
  end

  class Provider
    class Package
      class RbenvRubygems < Chef::Provider::Package::Rubygems
        include Chef::Mixin::Rbenv

        class RbenvGemEnvironment < AlternateGemEnvironment
          attr_reader :ruby_version

          def initialize(gem_binary_path, ruby_version)
            @ruby_version = ruby_version
            super(gem_binary_path)
          end
        end

        attr_reader :gem_binary_path

        def initialize(new_resource, run_context = nil)
          super
          @gem_binary_path = gem_binary_path_for(new_resource.ruby_version)
          @gem_env = RbenvGemEnvironment.new(gem_binary_path, new_resource.ruby_version)
        end

        def install_package(name, version)
          install_via_gem_command(name, version)
          rbenv_command("rehash")
          
          true
        end

        def remove_package(name, version)
          uninstall_via_gem_command(name, version)

          true
        end

        def install_via_gem_command(name, version)
          src = @new_resource.source && "  --source=#{@new_resource.source} --source=http://rubygems.org"
          shell_out!(
            "#{gem_binary_path} install #{name} -q --no-rdoc --no-ri -v \"#{version}\"#{src}#{opts}", 
            :user => 'rbenv',
            :group => 'rbenv',
            :env => {
              'RBENV_VERSION' => @new_resource.ruby_version
            }
          )
        end
      end
    end
  end
end
