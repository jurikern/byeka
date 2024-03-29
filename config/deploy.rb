require 'bundler/capistrano'
require 'capistrano_colors'

load 'config/recipes/base'
load 'config/recipes/nginx'
load 'config/recipes/unicorn'
load 'config/recipes/postgresql'
load 'config/recipes/nodejs'
load 'config/recipes/rbenv'
load 'config/recipes/check'

server '50.116.46.143', :web, :app, :db, primary: true

set :user, 'deployer'
set :application, 'byeka'
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, 'git'
set :repository, "git@github.com:Semjonow/#{application}.git"
set :branch, 'master'

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy', 'deploy:cleanup' # keep only the last 5 releases