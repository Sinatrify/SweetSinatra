require "sweetsinatra/version"

module SweetSinatra


  INPUT = ARGV
  COMMAND = INPUT[-2]
  APPNAME = INPUT[-1]

  def self.run
    if COMMAND == "new"
      setup
    elsif INPUT.include?("scaffold")
      scaffold
    else
      puts "Command not found"
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
    name = table.capitalize

    #model
    `rake generate:model NAME=#{name}`
    #migration
    filename = "%s_create_%s.rb" % [Time.now.strftime('%Y%m%d%H%M%S'), table]
    #path     = APP_ROOT.join('db', 'migrate', filename)
    path     = "db/migrate/#{filename}"

    if File.exist?(path)
      raise "ERROR: File '#{path}' already exists"
    end

    table_fields = Hash[fields.map{|a| a.split(":").to_a}]
    fields_str = ""
    table_fields.each do |column, data_type|
      fields_str << "t.#{data_type} :#{column} \n"
    end

    puts "Creating #{path}"
    File.open(path, 'w+') do |f|
      f.write(<<-EOF)
      class Create#{name} < ActiveRecord::Migration
        def change
          create_table :#{table}s do |t|
          #{fields_str}

          t.timestamps
        end
      end
    end
    EOF
  end
  #calling controller creation
  controller_name     = (name + 's_controller').capitalize
  controller_filename =  name.downcase + '.rb'
  controller_path = "app/controllers/#{controller_filename}"

  if File.exist?(controller_path)
    raise "ERROR: controller file '#{controller_path}' already exists"
  end

  puts "Creating #{controller_path}"
  File.open(controller_path, 'w+') do |f|
    f.write(<<-EOF)
    get '/' do
      @#{name.downcase} = #{name}.all
      erb :index
    end

    get '/new' do
      erb :new
    end

    post '/new' do
     #{name}.create(params)
     redirect to('/')
   end

   get '/show/:id' do
    @#{name.downcase} = #{name}.find(params[:id])
  end
  EOF
end
  #views
  view_filename = name.downcase + '.erb'
  view_path = "app/views"

  if File.exist?(view_path)
    raise "ERROR: view file '#{view_path}' already exists"
  end

  puts "Creating #{view_path}"
  `mkdir app/views`
  index = "index.erb"
  create = "new.erb"
  show = "show.erb"
  `touch app/views/index.erb app/views/new.erb app/views/show.erb`
  arr = [index, create, show]
  arr.each do |path|
    File.open(view_path + path, 'w+') do |f|
      if path == index
        f.write(<<-EOF)
        <% @#{name.downcase}.each do |#{name.downcase}| %>
          <%= #{name.downcase}.name %>
          <% end %>
          EOF
      elsif path == create
          f.write(<<-EOF)
          <form action='' method='post'>
          <input>
          <input>
          </form>
          EOF
      else
          f.write(<<-EOF)
          <h1>SHOW</h1>
          EOF
      end
    end
  end

end
end
