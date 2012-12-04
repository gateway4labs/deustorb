# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deustorb/version'

Gem::Specification.new do |gem|
  gem.name          = "deustorb"
  gem.version       = Deustorb::VERSION
  gem.authors       = ["Nicolás Hock Isaza"]
  gem.email         = ["nhocki@gmail.com"]
  gem.description   = %q{DeustoRB is a simple client for the WebLab Deusto remote laboratory platform.}
  gem.summary       = %q{DeustoRB is a simple client for the WebLab Deusto remote laboratory platform.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rest-client", "~> 1.6.7"

  gem.add_development_dependency 'rake', '~> 10.0.2'
  gem.add_development_dependency 'rspec', '~> 2.12.0'
  gem.add_development_dependency 'dotenv', '~> 0.4.0'
  gem.add_development_dependency 'fakeweb', '~> 1.3.0'
end
