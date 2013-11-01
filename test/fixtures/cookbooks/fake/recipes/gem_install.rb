include_recipe 'fake::ruby_install'

rbenv_gem 'bundler' do
  ruby_version node['fake']['ruby_version']
  version '1.3.5'
end
