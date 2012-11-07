name             "rbenv"
maintainer       "Riot Games"
maintainer_email "jamie@vialstudios.com"
license          "Apache 2.0"
description      "Installs and configures rbenv"
version          "1.4.1"

recipe "rbenv", "Installs and configures rbenv"
recipe "rbenv::ruby_build", "Installs and configures ruby_build"
recipe "rbenv::ohai_plugin", "Installs an rbenv Ohai plugin to populate automatic_attrs about rbenv and ruby_build"

%w{ centos redhat fedora ubuntu debian }.each do |os|
  supports os
end

%w{ git }.each do |cb|
  depends cb
end

depends 'ohai', '>= 1.1'
