require "bundler"
require 'deustorb'

Bundler.require(:default, :test, :development)

Dir[File.join(File.expand_path('../', __FILE__), "support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end