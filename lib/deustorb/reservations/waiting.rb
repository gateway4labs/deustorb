module Deustorb
  module Reservation
    class Waiting
      attr_reader :id, :status, :position

      def initialize(options)
        @id = options.fetch(:id)
        @position = options.fetch(:position)
        @status = Reservation::WAITING
      end
    end
  end
end