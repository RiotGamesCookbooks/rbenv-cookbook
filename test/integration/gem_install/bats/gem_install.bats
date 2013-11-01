@test "installs a gem into the correct Ruby" {
  # We have unset these vars to bust out of Busser's sandbox
  unset GEM_HOME GEM_PATH GEM_CACHE
  run /opt/rbenv/shims/gem list bundler -v 1.3.5 -i
  [ "$status" -eq 0 ]
}
