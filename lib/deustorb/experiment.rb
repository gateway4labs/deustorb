module Deustorb
  class Experiment
    TOKEN = "@"
    attr_accessor :id, :name, :category_name, :time_allowed

    def initialize(attrs = {})
      attrs.each do |key, value|
        self.public_send("#{key}=", value)
      end
      yield(self) if block_given?
    end

    def self.new_from_identifier(identifier)
      name, category = identifier.split(TOKEN)
      new(name: name, category_name: category)
    end
  end
end