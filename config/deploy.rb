require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "ShareThoughts"

# SCM related configuration
set :user, "az7ar"
set :scm, :git
set :scm_verbose, true
set :repository,  "https://github.com/genweb2/ShareThoughts.git"
set :branch, "master"
set :runner, user
set :deploy_to, "/home/az7ar/share_thoughts"

# RVM related configuration
set :rvm_ruby_string, 'ruby-1.9.3-p194@ShareThoughts'
set :rvm_type, :user
set :use_sudo, false
set :app_env, 'production'

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.1.226"                          # Your HTTP server, Apache/etc
role :app, "192.168.1.226"                          # This may be the same as your `Web` server
role :db,  "192.168.1.226", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
#after 'deploy:restart', 'unicorn:reload' # app IS NOT preloaded

#require 'capistrano-unicorn'

namespace :private_pub do
  desc 'Start private pub server'
  task :start, :roles => :app, :except => {:no_release => true} do
    run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec rackup #{current_path}/private_pub.ru -s thin -E #{app_env} -D -P #{current_path}/tmp/pids/private_pub_server.pid"
  end

  desc 'Stop private pub server'
  task :stop, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -s USR2 `cat #{current_path}/tmp/pids/private_pub_server.pid`"
  end

  desc 'Restart private pub server'
  task :restart, :roles => :app, :except => {:no_release => true} do
    run "#{try_sudo} kill -s USR2 `cat #{current_path}/tmp/pids/private_pub_server.pid`"
    run "cd #{current_path} && BUNDLE_GEMFILE=#{current_path}/Gemfile bundle exec rackup #{current_path}/private_pub.ru -E #{app_env} -D -P #{current_path}/tmp/pids/private_pub_server.pid"
  end
end

after 'deploy:restart', 'private_pub:restart'

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
end