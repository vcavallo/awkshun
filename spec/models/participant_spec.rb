require 'rails_helper'

RSpec.describe Participant, type: :model do
  describe "Attributes" do
    let(:participant) { FactoryGirl.create(:participant) }
  end

  describe "Associations" do
    let(:participant) { FactoryGirl.create(:participant) }

    it 'has many bids' do
      expect(participant).to have_many(:bids)
    end
  end

  describe "Features" do
    let(:participant) { FactoryGirl.create(:participant) }

    describe "#submit_bid" do
      let!(:auction) { FactoryGirl.create(:auction, live: true) }
      describe 'submits a bid on an auction for an amount' do
        context 'when the bid is accepted' do
          pending 'unclear what is needed as a return/response for this'
        end

        context 'when the bid is not accepted' do
          it 'raises an error with details from the auction' do
            allow_any_instance_of(Auction).to receive(:bid_accepted?)
              .with(100)
              .and_return({ accepted: false, message: "some message" })
            expect { participant.submit_bid(auction, 100) }
              .to raise_error "some message"
          end
        end
      end
    end
  end
end
