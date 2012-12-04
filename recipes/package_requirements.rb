package "curl"
include_recipe "build-essential"
include_recipe "git"

# TODO: have tested on ubuntu. have left others as is
case node[:platform]
when "redhat", "centos"
  # TODO: add as per "rvm requirements"
  package "openssl-devel"
  package "zlib-devel"
  package "readline-devel"
when "ubuntu", "debian"
  # rvm shows a list of packages required to build and use ruby
  # can see by typing 'rvm requirements'
  # it has both necessary and useful packages
  # we have covered all packages as given there other than sqlite and subversion
  # 
  # NOTE: http://stackoverflow.com/questions/13641163/what-are-the-dependencies-given-on-rvm-requirements-useful-for

  # another build-essential. useful for compiling code
  package "libc6-dev"
  package "automake"
  package "libtool"

  # https://github.com/sstephenson/ruby-build/issues/119
  # "It seems your ruby installation is missing psych (for YAML
  # output). To eliminate this warning, please install libyaml and
  # reinstall your ruby."
  package 'libyaml-dev'

  # needed to unpack rubygems
  package 'zlib1g'
  package 'zlib1g-dev'

  # openssl support for ruby
  package "openssl"
  package 'libssl-dev'

  # readline for irb and rails console
  package "libreadline-dev"

  # for ruby stdlib rexml and nokogiri 
  # http://nokogiri.org/tutorials/installing_nokogiri.html
  package "libxml2-dev"
  package "libxslt1-dev"

  # better irb support
  package "ncurses-dev"

  # for searching packages
  package "pkg-config"

  # for installing some old plugin
  # package "subversion"
end
