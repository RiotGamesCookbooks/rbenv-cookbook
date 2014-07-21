@test "installs the correct version of Ruby" {
  /opt/rbenv/shims/ruby --version | grep 1.9.3p448
}

@test "properly sets PATH environment variable" {
  . /etc/profile.d/rbenv.sh
  ruby --version | grep 1.9.3p448
}
