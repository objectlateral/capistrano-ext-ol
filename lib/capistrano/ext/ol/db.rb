require_relative "db_dumper"

Capistrano::Configuration.instance.load do
  namespace :db do
    def get_remote_config
      config = capture "cat #{shared_path}/config/database.yml"
      remote_env = exists?(:stage) ? stage : rails_env
      YAML::load(config)[remote_env.to_s]
    end

    def get_local_config
      YAML::load_file("config/database.yml")["development"]
    end

    desc "Snapshots remote db and dumps into local development db"
    task :pull, roles: :db, only: {primary: true} do
      remote = get_remote_config
      local  = get_local_config

      dumper = DbDumper.new remote, application

      run dumper.dump_to "/tmp"
      get dumper.file, dumper.file
      run dumper.rm_file

      system dumper.restore_to local
      system dumper.rm_file
    end

    desc "Create backup snapshot of remote db"
    task :backup, roles: :db, only: {primary: true} do
      remote = get_remote_config

      dumper = DbDumper.new remote, application

      on_rollback { dumper.rm_file }
      run "mkdir -p #{shared_path}/backup"
      run dumper.dump_to "#{shared_path}/backup"
    end
  end
end
