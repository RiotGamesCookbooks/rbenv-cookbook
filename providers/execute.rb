#
# Cookbook Name:: rbenv
# Provider:: execute
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#

use_inline_resources

action :run do
  @path        = [ shims_path, bin_path ] + (new_resource.path || Array.new) + system_path
  @environment = (new_resource.environment || Hash.new).merge(
    "RBENV_ROOT"    => root_path,
    "RBENV_VERSION" => new_resource.rbenv_version
  )

  execute new_resource.name do
    command     new_resource.command
    creates     new_resource.creates
    cwd         new_resource.cwd
    environment @environment
    group       new_resource.group
    path        @path
    returns     new_resource.returns
    timeout     new_resource.timeout
    user        new_resource.user
    umask       new_resource.user
  end
end

private

  def bin_path
    ::File.join(root_path, "bin")
  end

  def shims_path
    ::File.join(root_path, "shims")
  end

  def root_path
    "#{node[:rbenv][:install_prefix]}/rbenv"
  end

  def system_path
    shell_out!("echo $PATH").stdout.chomp.split(':')
  end
