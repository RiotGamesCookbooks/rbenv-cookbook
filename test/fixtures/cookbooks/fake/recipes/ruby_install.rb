
include_recipe 'rbenv::default'
include_recipe 'rbenv::ruby_build'

rbenv_ruby node['fake']['ruby_version'] do
  global true
end
