require 'rest-client'

module Deustorb
  # Weblab Deusto Client
  #
  # This class will be responsible forall the communitations between ruby and
  # the Weblab Deusto server.
  #
  # You need a `base_url` to initialize it. This URL is the server location.
  class Client
    attr_reader :base_url, :auth, :experiments

    def initialize(base_url)
      @base_url = base_url.sub(/\/+$/,'') # remove trailing `/`
    end

    # Logs in a client given a `username` and `password`.
    #
    # You need to call this method before any other calls. Otherwise an exception
    # will be raised.
    def login(username, password)
      params = {
        "method" => "login",
        "params" => {"username" => username, "password" => password}
      }
      @raw_auth = post(Deustorb.url_for(base_url, :login), params)
      @auth = JSON.parse(@raw_auth)
    end

    # Returns a boolean that indicates wether a client is authenticated
    # or not. Be careful that this *may* return true even if the session is
    # timed out.
    #
    # TODO: Fix the authentication being timed out false-positive.
    def authenticated?
      !auth.fetch('is_exception'){ true }
    end

    # Returns an array of `Experiments` from the server.
    #
    # If you are not `authenticated?` this will raise an error
    def list_experiments
      authenticated_request do
        params = {
          "method" => "list_experiments",
          "params" => {
            "session_id" => session_id
          }
        }
        result = post(Deustorb.url_for(base_url, :core), params, {:cookies => cookies})
        @experiments = parse_experiments(result)
      end
    end

    # Reserves an experiment in the server. You need to be authenticated. Otherwise
    # an exception will be raised.
    #
    # Returns a hash with the response from the server.
    #
    # parameters:
    #
    # experiment: A Deustorb::Experiment object. The one you want to reserve.
    #
    # client_initial_data: Extra data sent to the server. A Hash. Default to empty hash.
    #
    # consumer_data: The consumer data sent to the server. A Hash. Default to empty hash.
    def reserve_experiment(experiment, client_initial_data = {}, consumer_data = {})
      authenticated_request do
        params = {
          method: 'reserve_experiment',
          params: {
            client_initial_data: json_string(client_initial_data),
            session_id: session_id,
            consumer_data: json_string(consumer_data),
            experiment_id: {
              exp_name: experiment.name,
              cat_name: experiment.category_name
            }
          }
        }
        # TODO: Manage the response with our classes
        post(Deustorb.url_for(base_url, :core), params, {:cookies => cookies})
      end
    end

    private

    # Turns a hash into a JSON string if it's able to do it.
    # If not, returns the object (which is supposed to be a string)
    def json_string(object_or_string)
      JSON.dump(object_or_string) rescue object_or_string
    end

    # Creates an array of experiments from the response of the server
    # Parses the response and sets the experiment's attributes.
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

    # Returns a hash with the session ID information needed
    # for making calls to the server.
    def session_id
      {"id" => auth.fetch('result'){{}}.fetch('id') }
    end

    def post(url, params, headers = {})
      http_request(:post, url, params, headers)
    end

    def http_request(http_method, url, params = {}, headers = {})
      RestClient.public_send(http_method, url, JSON.dump(params), headers).tap do |response|
        json = JSON.parse(response)
        if json.fetch('is_exception') == true
          raise WebLabException.new(json['message'], json['code'])
        end
      end
    end

    # TODO: Raise a proper exception here.
    def authenticated_request
      raise "You must authenticate first" unless authenticated?
      yield
    end

    def cookies
      @raw_auth.cookies
    end
  end
end
