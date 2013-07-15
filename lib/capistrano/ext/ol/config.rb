Capistrano::Configuration.instance.load do
  namespace :config do
    desc "sets up config directory for use"
    task :setup do
      run "#{try_sudo} mkdir -p #{shared_path}/config"
    end

    desc "updates symlinks for yml configs found in shared directory"
    task :symlink do
      run "for f in `find #{shared_path}/config -maxdepth 1 -name *.yml`; do ln -nfs $f #{release_path}/config/`basename $f`; done"
    end
  end

  after "deploy:setup", "config:setup"
  after "deploy:finalize_update", "config:symlink"
end
