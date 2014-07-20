require "sweetsinatra/version"

module SweetSinatra


  INPUT = ARGV
  APPNAME = INPUT[-1]
  COMMAND = INPUT[-2]

  def self.run
    if COMMAND == "new"
      setup
    elsif INPUT.include?("scaffold")
      scaffold
    else
      puts "You looser MoFO!"
    end
  end

  def self.setup
    `git clone https://github.com/Sinatrify/Sinatra_Skeleton.git`
    `mv Sinatra_Skeleton #{APPNAME}`
    `rm -rf #{APPNAME}/.git`
  end

  def self.scaffold
    INPUT.shift(2)
    table = INPUT.shift
    fields = INPUT
    #[name:string age:integer dob:datetime description:text]
############
    name     = APPNAME.capitalize
    filename = "%s_create_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), APPNAME]
    #path     = APP_ROOT.join('db', 'migrate', filename)
    path     = "db/migrate/#{filename}"

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    table_fields = Hash[fields.map{|a| a.split(":").to_a}]
    fields_str = ""
    table_fields.each do |column, data_type|
      fields_str << "t.#{data_type} :#{column} "
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF.strip_heredoc)
      class Create#{name} < ActiveRecord::Migration
        def change
          create_table :#{name.downcase}s do |t|
            "#{fields_str}"

            t.timestamps
          end
        end
      end
      EOF
    end
  end
end
