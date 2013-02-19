require 'capistrano/ext/multistage'
require 'capistrano/novafabrica/base'
require 'bundler/capistrano'
#require 'capistrano/novafabrica/solr'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :stages, %w(staging production)
set :default_stage, "staging"
set :application, "Creativebug"
set :short_name, "Creativebug"
set :rails_root, "#{File.dirname(__FILE__)}/../"

set :scm, "git"
set :repository,  "git@github.com:novafabrica/nftix.git"
set :scm_user, "novafabrica"
set :repository_cache, "git_cache"
set :deploy_via, :remote_cache
set :use_sudo, false

# Only recompile assets which have changed
# http://www.bencurtis.com/2011/12/skipping-asset-compilation-with-capistrano/
# This does not override cap recipe, instead use this code to patch:
#   /gems/capistrano-2.9.0/lib/capistrano/recipes/deploy/assets.rb

