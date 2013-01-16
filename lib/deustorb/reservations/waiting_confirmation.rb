module Deustorb
  module Reservation
    class WaitingConfirmation
      attr_reader :id, :status, :url

      def initialize(options = {})
        @id = options.fetch(:id)
        @url = options.fetch(:url)
        @status = Reservation::WAITING_CONFIRMATION
      end
    end
  end
end
