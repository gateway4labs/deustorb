require 'spec_helper'

module Deustorb
  module Reservation
    describe PostReservation do
      let(:params) do
        {
          id: 'some-id',
          finished: true,
          end_data: 'another-id',
          initial_data: '{some initial data}'
        }
      end

      let(:reservation) { Deustorb::Reservation::PostReservation.new(params) }

      it "has a post reservation status" do
        expect(reservation.status).to eql(Reservation::POST_RESERVATION)
      end

      # allow me to use the `params` method. Since it's an instance method
      # I need to create a new instance. This sucks, but oh well, works.
      new.params.keys.each do |key|
        it "has a #{key}" do
          expect(reservation.send(key)).to eql(params[key.to_sym])
        end
      end
    end
  end
end