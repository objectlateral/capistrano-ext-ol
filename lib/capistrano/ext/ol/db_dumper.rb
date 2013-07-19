class DbDumper < Struct.new :config, :application
  def initialize *args
    super

    case config["adapter"]
    when "postgresql" then @adapter = PgDumper.new
    else
      raise "Only Postgres is supported atm"
    end
  end

  def dump_to path
    @path = path
    @adapter.dump_command config, file
  end

  def restore_to user, db
    @adapter.restore_command user, db, file
  end

  def file
    ts = Time.now.strftime "%Y-%m-%d-%H:%M:%S"
    @file ||= "#{@path}/#{ts}-#{application}.#{@adapter.file_ext}"
  end

  def rm_file
    "rm #{file}"
  end
end

class PgDumper
  def dump_command config, file
    %{pg_dump -x -Fc #{config["database"]} -f #{file}}
  end

  def restore_command user, db, file
    %{pg_restore --clean --no-acl --no-owner -U #{user} -d #{db} #{file}}
  end

  def file_ext; "psql"; end
end
