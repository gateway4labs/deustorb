module Deustorb
  module Reservation
    # This is the name on every other client, so I'll leave it like this.
    class PostReservation
      attr_reader :id, :status, :finished, :initial_data, :end_data

      def initialize(options = {})
        @id = options.fetch(:id)
        @finished = options.fetch(:finished)
        @end_data = options.fetch(:end_data)
        @initial_data = options.fetch(:initial_data)
        @status = Reservation::POST_RESERVATION
      end
    end
  end
end