maintainer       "Riot Games"
maintainer_email "jwinsor@riotgames.com"
license          "Apache 2.0"
description      "Installs and configures rbenv"
version          "0.9.0"

%w{ centos redhat fedora }.each do |os|
  depends os
end

%w{ git }.each do |cb|
  depends cb
end
