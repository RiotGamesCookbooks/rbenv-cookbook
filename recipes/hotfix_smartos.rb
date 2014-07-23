#
# Cookbook Name:: rbenv
# Recipe:: hotfix_smartos
#
# Author:: SAWANOBORI Yukihiko (<sawanoboriyu@higanworks.com>)
#
# Copyright 2011-2014, HiganWorks LLC
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

directory '/etc/profile.d' do
  action :create
end

ruby_block 'edit_profile_for_smartos' do
  block do
    _file = Chef::Util::FileEdit.new('/etc/profile')
    _file.insert_line_if_no_match('Appends by rbenv cookbook', "## Appends by rbenv cookbook\nif [ -d /etc/profile.d ]; then\n  for i in /etc/profile.d/*.sh; do\n    if [ -r $i ]; then\n      . $i\n    fi\n  done\n  unset i\nfi\n")
    _file.write_file
  end
end
