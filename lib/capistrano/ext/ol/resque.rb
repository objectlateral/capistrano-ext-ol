Capistrano::Configuration.instance.load do
  namespace :resque do
    desc "Kills all resque workers so that monit will restart them"
    task :restart do
      run [
        "for pid in #{shared_path}/pids/resque*.pid; do",
        "if [ -f $pid ];",
        "then kill -s QUIT `cat $pid`",
        "&& rm -f $pid;",
        "fi;",
        "done"
      ].join " "
    end
  end

  after "deploy:restart", "resque:restart"
end
