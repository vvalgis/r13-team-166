# ------------------------------------------------------------------------------
# Scriba rails 4 config
# ------------------------------------------------------------------------------

# Set your full path to application.
app_path = '/home/deployer/scriba/current'

# Set unicorn options
worker_processes 4
preload_app true
timeout 180
listen "/tmp/.scriba-unicorn.sock", :backlog => 64

# Spawn unicorn master worker for user apps (group: apps)
user 'deployer', 'deployer' 

# Fill path to your app
working_directory app_path

# Should be 'production' by default, otherwise use other env 
rails_env = ENV['RAILS_ENV'] || 'production'

# Log everything to one file
stderr_path "log/unicorn.err.log"
stdout_path "log/unicorn.std.log"

# Set master PID location
pid "#{app_path}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end