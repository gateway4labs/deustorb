require 'spec_helper'

module Deustorb
  module Reservation
    describe WaitingInstances do
      let(:reservation) do
        Deustorb::Reservation::WaitingInstances.new(id: 'some-id', position: 3)
      end

      it "has a waiting status" do
        expect(reservation.status).to eql(Reservation::WAITING_INSTANCES)
      end

      it "has an id" do
        expect(reservation.id).to eql('some-id')
      end

      it "has a position" do
        expect(reservation.position).to eql(3)
      end

      describe "#initialize options" do
        it "requires an id key" do
          expect{ WaitingInstances.new(position: 3) }.to raise_error(KeyError)
        end

        it "requires a position key" do
          expect{ WaitingInstances.new(id: 'some-id') }.to raise_error(KeyError)
        end
      end
    end
  end
end