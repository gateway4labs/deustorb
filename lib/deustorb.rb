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
  class Error < StandardError; end

  class WebLabException < Error
    attr_reader :message, :code

    def initialize(message = nil, code = nil)
      @message, @code = message, code
    end

    def to_s
      @message
    end
  end
end
