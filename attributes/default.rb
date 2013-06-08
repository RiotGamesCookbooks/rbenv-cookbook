#
# Cookbook Name:: rbenv
# Attributes:: default
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

default[:rbenv][:group_users]         = Array.new
default[:rbenv][:git_repository]      = "git://github.com/sstephenson/rbenv.git"
default[:rbenv][:git_revision]        = "master"
default[:rbenv][:install_prefix]      = "/opt"

# This can be `git` or `file`. If git, rbenv is installed from GitHub 
# like a standard install. If `file`, it is installed by using a file
# from the cookbook. See node[:rbenv][:filename] below
default[:rbenv][:install_method] = "git"

# Path to rbenv tar.gz file. Assumed to have an name in the form
# `rbenv-version.tar.gz` which contains a directory
# `rbenv-master`. This is based on what you get when you download
# the master branch as a tarball from GitHub
default[:rbenv][:filename]       = nil
default[:rbenv][:cookbook]       = nil

default[:ruby_build][:git_repository] = "git://github.com/sstephenson/ruby-build.git"
default[:ruby_build][:git_revision]   = "master"

# See node[:rbenv][:install_method] above
default[:ruby_build][:install_method] = "git"
# Path to ruby-build tar.gz file. Assumed to have an name in the form
# `ruby-build-version.tar.gz` which contains a directory
# `ruby-build-version`.
default[:ruby_build][:filename]       = nil
default[:ruby_build][:cookbook]       = nil

default[:rbenv_vars][:git_repository] = "git://github.com/sstephenson/rbenv-vars.git"
default[:rbenv_vars][:git_revision]   = "master"
