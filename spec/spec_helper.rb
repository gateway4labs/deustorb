require 'rspec'
require "bundler/setup"
require 'deustorb'

# Fuck you Bundler
Bundler.require.each{|dp| require dp.name }

Dir[File.join(File.expand_path('../', __FILE__), "support/**/*.rb")].each {|f| puts f; require f}

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end