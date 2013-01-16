require 'spec_helper'

module Deustorb
  module Reservation
    describe WaitingConfirmation do
      def reservation
        Deustorb::Reservation::WaitingConfirmation.new(id: 'some-id', url: 'example.com')
      end

      it "has a waiting status" do
        expect(reservation.status).to eql(Reservation::WAITING_CONFIRMATION)
      end

      it "has an id" do
        expect(reservation.id).to eql('some-id')
      end

      it "has a position" do
        expect(reservation.url).to eql('example.com')
      end

      describe "#initialize options" do
        it "requires an id key" do
          expect{ WaitingConfirmation.new(url: 'example.com') }.to raise_error(KeyError)
        end

        it "requires a url key" do
          expect{ WaitingConfirmation.new(id: 'some-id') }.to raise_error(KeyError)
        end
      end
    end
  end
end