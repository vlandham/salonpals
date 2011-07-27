require "bundler/capistrano"

$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.2@rails3'        # Or whatever env you want it to run in.
set :rvm_bin_path, "/usr/local/rvm/bin"

set :application, "salonpals"
set :repository,  "git@10.0.1.5:salonpals"

set :deploy_via, :copy
set :scm, :git
set :scm_username, "vlandham"


set :user, 'ubuntu'
set :use_sudo, false
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "ec2")] 


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
role :web, "ec2-107-20-17-143.compute-1.amazonaws.com"                          # Your HTTP server, Apache/etc
role :app, "ec2-107-20-17-143.compute-1.amazonaws.com"                          # This may be the same as your `Web` server
role :db,  "ec2-107-20-17-143.compute-1.amazonaws.com", :primary => true # This is where Rails migrations will run

set :deploy_to, "/var/rails/#{application}"

#before "deploy", "deploy:bundle_gems"
#before "deploy:restart", "deploy:bundle_gems"

set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"
#set :bundle, "bundle"
set :unicorn_rails, "unicorn_rails"

namespace :deploy do
#  task :bundle_gems do
#    run "cd #{deploy_to}/current && #{bundle} install --path vendor/gems" 
#  end

  task :start, :roles => :app, :except => { :no_release => true} do
    run "#{unicorn_rails} -c #{deploy_to}/current/config/unicorn.rb -D -E production"
  end
  
  task :stop, :roles => :app, :except => { :no_release => true} do
    run "kill `cat #{unicorn_pid}`" 
  end
  
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{unicorn_pid}`"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end

after "migration:reload", "deploy:restart"
namespace :migration do
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "cd #{deploy_to}/current && rake db:drop:all && rake db:migrate RAILS_ENV='production' && rake db:seed RAILS_ENV='production'"
  end
end

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