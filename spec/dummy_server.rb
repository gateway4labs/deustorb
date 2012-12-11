lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spec_helper'
require 'sinatra/base'

module Deustorb
  class Dummy < Sinatra::Base
    use Rack::Logger
    set :sessions, true

    before do
      content_type :json
      logger.info("\n\nParams: #{real_params}\n\n")
    end

    helpers do
      def logger
        request.logger
      end
    end

    get '/' do
      'Hello dummy deusto server!'
    end

    post '/login/json/?' do
      # accept any username/password for now
      login_response
    end

    post '/json/?' do
      Responder.public_send(real_params['method'])
    end

    private

    # Sorry but the way the params are received by Sinatra is kind of ugly
    # so I needed to turn do this.
    #
    # In the actions, use `real_params` instead of `params`
    def real_params
      JSON.parse params.first.first
    end
  end

  # Responses from the Weblab Deusto client
  # These responses are read from ./spec/support/helpers.rb
  class Responder
    def self.list_experiments
      experiments_list
    end

    def reserve_experiment
      waiting_reservation
    end
  end
end