require "json"
require "deustorb/version"
require "deustorb/client"
require "deustorb/experiment"
require "deustorb/reservation"

module Deustorb
  def self.url_for(base_url, action)
    base_url + url_map[action]
  end

  def self.url_map
    {
      :core   => "/json/",
      :login  => "/login/json/"
    }
  end

  # A general DeustoRB exception
  class Error < ::StandardError
    def initialize(message = nil)
      @message = message
    end

    def to_s
      @message || super
    end
  end

  class WebLabException < Error
    attr_reader :code

    def initialize(message = nil, code = nil)
      @message, @code = message, code
    end
  end

  class InvalidReservation < Error; end
end
