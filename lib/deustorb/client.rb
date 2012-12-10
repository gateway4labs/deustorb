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
            "session_id" => session_id
          }
        }
        @experiments = parse_experiments(post(Deustorb.url_for(base_url, :core), params, {:cookies => cookies}))
      end
    end

    def reserve_experiment(experiment, client_initial_data, consumer_data)
      serialized_experiment_id = {
        'exp_name' => experiment.exp_name,
        'cat_name' => experiment.cat_name
      }
    end

    private

    def parse_experiments(response)
      JSON.parse(response).fetch('result'){[]}.map do |exp_hash|
        Experiment.new do |exp|
          exp.id            = exp_hash.fetch('experiment').fetch('id')
          exp.name          = exp_hash.fetch('experiment').fetch('name')
          exp.time_allowed  = exp_hash.fetch('time_allowed')
          exp.category_name = exp_hash.fetch('experiment').fetch('category').fetch('name')
        end
      end
    end

    def session_id
      {"id" => auth.fetch('result'){{}}.fetch('id') }
    end

    def post(url, params, headers = {})
      http_request(:post, url, params, headers)
    end

    def http_request(http_method, url, params, headers = {})
      RestClient.public_send(http_method, url, JSON.dump(params), headers)
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
