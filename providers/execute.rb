#
# Cookbook Name:: rbenv
# Provider:: execute
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#

include Chef::Mixin::Rbenv

def load_current_resource
  @path                         = [ rbenv_shims_path, rbenv_bin_path ] + new_resource.path + system_path
  # duplicate because the original one is frozen
  @environment                  = new_resource.environment.dup
  @environment["PATH"]          = @path.join(":")
  @environment["RBENV_ROOT"]    = rbenv_root_path
  @environment.delete("RBENV_VERSION") if !new_resource.ruby_version
  @environment["RBENV_VERSION"] = new_resource.ruby_version if new_resource.ruby_version
  @environment["PKG_CONFIG_PATH"] = "/usr/lib/x86_64-linux-gnu/pkgconfig"

  new_resource.environment(@environment)
end

action :run do
  execute "eval \"$(rbenv init -)\"" do
    environment new_resource.environment
  end

  execute new_resource.name do
    command     new_resource.command
    creates     new_resource.creates
    cwd         new_resource.cwd
    environment new_resource.environment
    group       new_resource.group
    live_stream new_resource.live_stream
    retries     new_resource.retries
    retry_delay new_resource.retry_delay
    returns     new_resource.returns
    timeout     new_resource.timeout
    user        new_resource.user
    umask       new_resource.umask
  end

  new_resource.updated_by_last_action(true)
end

private

  def system_path
    shell_out!("echo $PATH").stdout.chomp.split(':')
  end
