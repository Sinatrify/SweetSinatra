require "sweetsinatra/version"

module SweetSinatra
  #sweet sinatra appname
  APPNAME = ARGV.pop
  COMMAND = ARGV.pop
  def self.run
    if COMMAND == "sinatra"
      setup
    end
  end

  def self.setup
    `git clone https://github.com/Sinatrify/Sinatra_Skeleton.git`
    `rm -rf .git`
    `mv Sinatra_Skeleton #{APPNAME}`
    `cd #{APPNAME}`
    `git init`
  end
end
