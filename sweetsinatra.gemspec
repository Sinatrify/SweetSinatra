# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sweet/version'

Gem::Specification.new do |spec|
  spec.name          = "sweet"
  spec.version       = SweetSinatra::VERSION
  spec.authors       = ["Puru Dahal", "Arik Gadye", "Sebastian Belmar"]
  spec.email         = ["pdahal@me.com", "arikdovgadye@gmail.com", "si.belmar@gmail.com"]
  spec.summary       = %q{Sinatra Skeleton and Scaffold Generator}
  spec.description   = %q{This gems will help you generate Sinatra Skeleton and CRUD Scaffold.}
  spec.homepage      = "https://github.com/Sinatrify/SweetSinatra"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["sweet"]
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
