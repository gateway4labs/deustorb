module Deustorb
  module Reservation
    class WaitingInstances
      attr_accessor :id, :status, :position

      def initialize(options = {})
        @id = options.fetch(:id)
        @position = options.fetch(:position)
        @status = Reservation::WAITING_INSTANCES
      end
    end
  end
end