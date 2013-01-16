require 'active_support'
require 'active_support/core_ext/string'

require 'deustorb/reservations/waiting'
require 'deustorb/reservations/confirmed'
require 'deustorb/reservations/post_reservation'
require 'deustorb/reservations/waiting_instances'
require 'deustorb/reservations/waiting_confirmation'

module Deustorb
  module Reservation
    WAITING = 'waiting'
    CONFIRMED = 'confirmed'
    POST_RESERVATION = 'post_reservation'
    WAITING_INSTANCES = 'waiting_instances'
    WAITING_CONFIRMATION = 'waiting_confirmation'

    TOKEN = 'Reservation::'
    def self.new_from_hash(data = {})
      reservation_type = data.delete('status'){ raise ::KeyError.new('key not found: "status"') }
      reservation_type.sub!(TOKEN, "")
      data = normalize_data_hash(data)
      unless valid_types.include?(reservation_type)
        raise InvalidReservation.new("Invalid reservation type: '#{reservation_type}'\n\nValid Types: #{valid_types.join(", ")}")
      end
      if reservation_type == WAITING_INSTANCES
        WaitingInstances.new data
      else
        "Deustorb::Reservation::#{reservation_type.classify}".constantize.new(data)
      end
    end

    def self.valid_types
      [
        WAITING,
        CONFIRMED,
        POST_RESERVATION,
        WAITING_INSTANCES,
        WAITING_CONFIRMATION
      ]
    end

    private
    def self.normalize_data_hash(data)
      # force both keys to be present
      data['id'] = data.fetch("reservation_id").fetch("id")
      data.delete("reservation_id")
      simbolize_hash_keys(data)
    end

    def self.simbolize_hash_keys(hash)
      hash.keys.each do |key|
        if key.is_a?(String)
          hash[key.to_sym] = hash[key]
          hash.delete(key)
        end
      end
      hash
    end
  end
end