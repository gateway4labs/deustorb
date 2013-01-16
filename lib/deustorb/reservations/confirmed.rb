module Deustorb
  module Reservation
    class Confirmed
      attr_reader :id, :status, :time, :initial_configuration, :url, :remote_reservation_id

      def initialize(options = {})
        @id   = options.fetch(:id)
        @url  = options.fetch(:url)
        @time = options.fetch(:time)
        @remote_reservation_id = options.fetch(:remote_reservation_id)
        @initial_configuration = options.fetch(:initial_configuration)

        @status = Reservation::CONFIRMED
      end
    end
  end
end