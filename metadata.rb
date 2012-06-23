name             "rbenv"
maintainer       "Riot Games"
maintainer_email "jamie@vialstudios.com"
license          "Apache 2.0"
description      "Installs and configures rbenv"
version          "1.3.2"

recipe "rbenv", "Delegates to recipe[rbenv::system_install]"
recipe "rbenv::system_install", "Configures a node with a system wide rbenv and ruby_build installation accessible by users in the rbenv group"
recipe "rbenv::ruby_build", "Installs ruby_build to a node which enables rbenv the ability to install and manage versions of Ruby"
recipe "rbenv::ohai_plugin", "Installs an rbenv Ohai plugin onto the node to automatically populate attributes about the rbenv installation"

%w{ centos redhat fedora ubuntu debian }.each do |os|
  supports os
end

%w{ git }.each do |cb|
  depends cb
end

depends 'ohai', '~> 1.0.2'
