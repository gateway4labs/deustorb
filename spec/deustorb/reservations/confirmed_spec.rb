require 'spec_helper'

module Deustorb
  module Reservation
    describe Confirmed do
      let(:params) do
        {
          id: 'some-id',
          url: 'example.com',
          time: 'some-time',
          initial_configuration: 'oh yeah',
          remote_reservation_id: 'another-id'
        }
      end

      let(:reservation) { Deustorb::Reservation::Confirmed.new(params) }

      it "has a confirmed status" do
        expect(reservation.status).to eql(Reservation::CONFIRMED)
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