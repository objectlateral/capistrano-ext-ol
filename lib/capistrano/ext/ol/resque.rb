Capistrano::Configuration.instance.load do
  namespace :resque do
    desc "Kills resque workers so that monit will restart them"
    task :restart do
      pid = "#{shared_path}/pids/resque.pid"
      run "if [ -f #{pid} ]; then kill -s QUIT `cat #{pid}` && rm -f #{pid}; fi"
    end
  end
end
