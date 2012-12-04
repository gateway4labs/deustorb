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
      @raw_auth = RestClient.post(url_for(:login), JSON.dump(params))
      @auth = JSON.parse(@raw_auth.to_s)
    end

    def authenticated?
      !auth.fetch('is_exception'){ true }
    end

    private

    def cookies
      @raw_auth.cookies
    end

    def url_for(action)
      url_map[action]
    end

    def url_map
      {
        :core   => "#{base_url}/json/",
        :login  => "#{base_url}/login/json/"
      }
    end
  end
end
