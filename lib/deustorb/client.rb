require 'rest-client'

module Deustorb
  class Client
    attr_reader :base_url, :auth, :experiments

    def initialize(base_url)
      @base_url = base_url.sub(/\/+$/,'') # remove trailing `/`
    end

    def login(username, password)
      params = {
        "method" => "login",
        "params" => {"username" => username, "password" => password}
      }
      @raw_auth = post(Deustorb.url_for(base_url, :login), params)
      @auth = JSON.parse(@raw_auth.to_s)
    end

    def authenticated?
      !auth.fetch('is_exception'){ true }
    end

    def list_experiments
      authenticated_request do
        params = {
          "method" => "list_experiments",
          "params" => {
            "session_id" => {"id" => auth.fetch('result'){{}}.fetch('id') }
          }
        }
        @experiments = JSON.parse post(Deustorb.url_for(base_url, :core), params)
      end
    end

    private

    def post(url, params)
      http_request(:post, url, params)
    end

    def http_request(method, url, params)
      RestClient.public_send(method, url, JSON.dump(params))
    end

    def authenticated_request
      raise "You must authenticate first" unless authenticated?
      yield
    end

    def cookies
      @raw_auth.cookies
    end
  end
end
