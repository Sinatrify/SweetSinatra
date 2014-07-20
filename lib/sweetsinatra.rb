require "sweetsinatra/version"

module SweetSinatra
  #sweet sinatra appname
  APPNAME = ARGV.pop
  COMMAND = ARGV.pop
  def self.run
    if COMMAND == "new"
      setup
    end
  end

  def self.setup
    `git clone https://github.com/Sinatrify/Sinatra_Skeleton.git`
    `mv Sinatra_Skeleton #{APPNAME}`
    `rm -rf #{APPNAME}/.git`
  end
end
