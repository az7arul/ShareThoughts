require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "ShareThoughts"

# SCM related configuration
set :user, "azhar"
set :scm, :git
set :scm_verbose, true
set :repository,  "https://github.com/genweb2/ShareThoughts.git"
set :branch, "master"
set :runner, user
set :deploy_to, "/home/azhar/share_thoughts"

# RVM related configuration
set :rvm_ruby_string, 'ruby-1.9.3@ShareThoughts'
set :rvm_type, :user
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.1.19"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.19"                          # This may be the same as your `Web` server
role :db,  "192.168.1.19", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded

require 'capistrano-unicorn'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end