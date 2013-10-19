require 'bundler/capistrano'

set :rvm_require_role, :rvm
set :rvm_ruby_string, :ruby2
set :rvm_autolibs_flag, "read-only"
set :rvm_type, :user
require 'rvm/capistrano'

set :application, "scriba"
set :repository,  "git@github.com:railsrumble/r13-team-166.git"
set :scm,         :git
set :branch,      :master
set :rails_env, "production"
set :deploy_to,   "/home/deployer/#{application}"
set :deploy_via,  :remote_cache
set :git_enable_submodules, 1

set :use_sudo,    false
set :user,        "deployer"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

server "173.255.212.52", :app, :web, :db, :rvm, :primary => true

before "deploy:finalize_update", "scriba:symlink"
after 'deploy:restart', 'unicorn:duplicate'


namespace :scriba do
  desc "Make symlink for additional files"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

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

keys_config_file = File.join(File.dirname(__FILE__), 'keys.rb')
load(keys_config_file) if File.exists?(keys_config_file)