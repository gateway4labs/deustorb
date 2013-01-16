require 'spec_helper'

module Deustorb
  describe Reservation do
    describe ".new_from_hash" do
      let(:params) do
        {
          url: 'example.com',
          time: 'some-time-somewhen',
          finished: true,
          position: 3,
          end_data: 'end data',
          initial_data: 'initial data',
          initial_configuration: 'initial configuration',
          remote_reservation_id: 'remote-reservation-id',
          "reservation_id" => {"id" => 'some-reservation-id'}
        }
      end

      Reservation.valid_types.each do |type|
        it "instantiates a #{type} reservation" do
          params['status'] = type
          expect(Reservation.new_from_hash(params.clone).status).to eql(type)
        end
      end

      it "raises an exception for an invalid type" do
        params['status'] = "An invalid type"
        expect{Reservation.new_from_hash(params.clone)}.to raise_error(Deustorb::InvalidReservation)
      end
    end
  end
end
