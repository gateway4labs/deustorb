require "json"
require "deustorb/version"
require "deustorb/client"

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
end
