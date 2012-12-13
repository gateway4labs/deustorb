require 'spec_helper'
module Deustorb
  describe Reservation do
    describe ".new_from_response" do
      before { fake_it(core_services_url, waiting_reservation) }
      it "Creates a reservation based on the status of the reservation" do
        
      end
    end
  end
end