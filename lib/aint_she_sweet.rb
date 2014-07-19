require "aint_she_sweet/version"

module AintSheSweet
  APPNAME = ARGV.pop
  COMMAND = ARGV.join(" ")
  def self.run
    if COMMAND == "sweet sinatra"
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
