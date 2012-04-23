# rbenv cookbook

Installs and manages your versions of Ruby and Gems in Chef with rbenv and ruby_build

* [rbenv](https://github.com/sstephenson/rbenv)
* [ruby_build](https://github.com/sstephenson/ruby-build)

# Requirements

* Chef 10
* Centos / Redhat / Fedora / Ubuntu / Debian

# Attributes

## rbenv

* `rbenv[:group_users]`     - Array of users belonging to the rbenv group
* `rbenv[:git_repository]`  - Git url of the rbenv repository to clone
* `rbenv[:git_revision]`    - Revision of the rbenv repository to checkout
* `rbenv[:install_prefix]`  - Path prefix rbenv will be installed into

## ruby_build

* `ruby_build[:git_repository]` - Git url of the ruby_build repository to clone
* `ruby_build[:git_revision]`   - Revision of the ruby_build repository to checkout
* `ruby_build[:prefix]`         - Path prefix where ruby_build will be installed to

# Recipes

## default

Delegates to `recipe[rbenv::system_install]`

## system_install

Configures a node with a system wide rbenv and ruby_build installation accessible by users in the rbenv group

## ruby_build

Installs ruby_build to a node which enables rbenv the ability to install and manage versions of Ruby

## ohai_plugin

Installs an rbenv Ohai plugin onto the node to automatically populate attributes about the rbenv installation

# Resources / Providers

## rbenv_ruby

Install specified version of Ruby to be managed by rbenv

### Actions
Action  | Description                 | Default
------- |-------------                |---------
install | Install the version of Ruby | Yes

### Attributes
Attribute    | Description                                                 | Default
-------      |-------------                                                |---------
ruby_version | the ruby version and patch level you wish to install        | name
force        | install even if this version is already present (reinstall) | false
global       | set this ruby version as the global version                 | false

### Examples

##### Installing Ruby 1.9.2-p290

    rbenv_ruby "1.9.2-p290"

##### Forcefully install Ruby 1.9.3-p0

    rbenv_ruby "Ruby 1.9.3" do
      ruby_version "1.9.3-p0"
      force true
    end

## rbenv_gem

Install specified RubyGem for the specified ruby_version managed by rbenv

### Actions
Action  | Description                           | Default
------- |-------------                          |---------
install | Install the gem                       | Yes
upgrade | Upgrade the gem to the given version  |
remove  | Remove the gem                        |
purge   | Purge the gem and configuration files |

### Attributes
Attribute     | Description                                        | Default
-------       |-------------                                       |---------
package_name  | Name of given to modify                            | name
ruby_version  | Ruby of version the gem belongs to                 |
version       | Version of the gem to modify                       |
source        | Specified if you have a local .gem file to install |
gem_binary    | Override for path to gem command                   |
response_file |                                                    |
options       | Additional options to the underlying gem command   |

### Examples

##### Installing Bundler for Ruby 1.9.2-p290

    rbenv_gem "bundler" do
      ruby_version "1.9.2-p290"
    end

# Definitions

## rbenv_installation

Installs and configures rbenv into the desired place on your file system. Used internally by the `system_install` recipe, but can be leveraged in recipes of your own.

Currently only supports a system wide install. User specific installations to come.

### Parameters

Name                | Description                                    | Default
-----               |-------------                                   |--------
git_repository      | git repository to clone the rbenv project from | 'git://github.com/sstephenson/rbenv.git'
git_revision        | git revision of the rbenv project to clone     | 'master'
rbenv_root          | path to clone rbenv into                       | '/opt/rbenv'

### Example

    rbenv_installation do
      git_repository 'git://github.com/sstephenson/rbenv.git'
      git_revision 'master'
      rbenv_root '/opt/rbenv'
    end


# Releasing

1. Install the prerequisite gems

        $ gem install chef
        $ gem install thor

2. Increment the version number in the metadata.rb file

3. Run the Thor release task to create a tag and push to the community site

        $ thor release

# License and Author

Author:: Jamie Winsor (<jamie@vialstudios.com>)

Copyright 2011, Riot Games

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
