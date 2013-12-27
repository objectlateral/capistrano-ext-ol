class DbDumper < Struct.new :config, :application
  def initialize *args
    super

    @adapter = case config["adapter"]
    when "postgresql", "postgis" then PgDumper.new
    when "mysql", "mysql2" then MySqlDumper.new
    else
      raise "Only Postgres/MySQL is supported atm"
    end
  end

  def dump_to path
    @path = path
    @adapter.dump_command config, file
  end

  def restore_to config
    @adapter.restore_command config, file
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

  def restore_command config, file
    %{pg_restore --clean --no-acl --no-owner -U #{config["username"]} -d #{config["database"]} #{file}}
  end

  def file_ext; "psql"; end
end

class MySqlDumper
  def dump_command config, file
    %{mysqldump #{args(config)} #{config["database"]} > #{file}}
  end

  def restore_command config, file
    %{mysql #{args(config)} #{config["database"]} < #{file}}
  end

  def file_ext; "sql"; end

  private

  def args config
    args = ["--user=#{config["username"]}"]

    if password = config["password"]
      args.push "--password=#{password}"
    end

    args.join " "
  end
end
