#$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'capistrano/ext/multistage'
require 'rvm/capistrano'
require 'bundler/capistrano'

#set :bundle_dir, ""
set :stages, %w(staging production)
set :default_stage, "staging"
set :rvm_ruby_string, 'ruby-1.9.3-p392@glico'
set :rvm_type, :system
set :rvm_bin_path, "/usr/local/rvm/bin"

# main details
set :application, "glico"

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
#set :user, "app_user"
set :password, "fjwoe83nf"
set :use_sudo, false

# repository
set :scm,         :git
set :repository,  "git@kembo88.com:/home/git/repos/glico.git"
set :branch,      'master'
set :keep_releases, 5
set :deploy_via, :remote_cache
set :repository_cache, "cached_copy"
after "deploy", "deploy:cleanup"
