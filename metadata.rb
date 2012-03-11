name             "rbenv"
maintainer       "Riot Games"
maintainer_email "jamie@vialstudios.com"
license          "Apache 2.0"
description      "Installs and configures rbenv"
version          "1.0.2"

%w{ centos redhat fedora }.each do |os|
  supports os
end

%w{ git }.each do |cb|
  depends cb
end
