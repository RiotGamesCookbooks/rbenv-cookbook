#
# Cookbook Name:: rbenv
# Library:: matchers
#
# Author:: Kai Forsthoevel (<kai.forsthoevel@injixo.com>)
#
# Copyright 2014, injixo
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

if defined?(ChefSpec)
  def install_rbenv_ruby(ruby_version)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_ruby, :install, ruby_version)
  end

  def install_rbenv_gem(package_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :install, package_name)
  end

  def upgrade_rbenv_gem(package_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :upgrade, package_name)
  end

  def remove_rbenv_gem(package_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :remove, package_name)
  end

  def purge_rbenv_gem(package_name)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_gem, :purge, package_name)
  end

  def run_rbenv_execute(command)
    ChefSpec::Matchers::ResourceMatcher.new(:rbenv_execute, :run, command)
  end
end
