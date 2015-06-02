require 'rails_helper'

RSpec.describe Auction, type: :model do
  #describe "Validations" do
  #  let(:auction) { FactoryGirl.create(:auction) }

  #  it 'has a valid factory' do
  #    expect(auction).to be_valid
  #  end
  #end

  describe "Attributes" do
    let(:auction) { FactoryGirl.create(:auction) }

    it 'has a success status' do
      expect(auction).to respond_to(:success)
    end

    it 'has a live status' do
      expect(auction).to respond_to(:live)
    end

    it 'starts off not-live' do
      expect(Auction.new.live?).to eq false
    end
  end

  describe "Associations" do
    let(:auction) { FactoryGirl.create(:auction) }

    it 'has an item' do
      expect(auction).to have_one(:item)
    end

    it 'has many bids' do
      expect(auction).to have_many(:bids)
    end
  end

  describe "Features" do
    let(:auction) { FactoryGirl.create(:auction) }

    describe "#go_live!" do
      it 'sets the auction\'s live status to true' do
        expect(auction.live?).to eq false
        auction.go_live!
        expect(auction.live?).to eq true
      end
    end

    describe "#bid_accepted?" do
      let!(:auctioned_item) {
        FactoryGirl.create(
          :item,
          reserved_price: 10,
          auction_id: auction.id
        )
      }

      describe 'determines if the passed amount is a legal bid' do
        let!(:a_low_bid) {
          FactoryGirl.create(
            :bid,
            auction_id: auction.id,
            amount: 5
          )
        }

        let!(:a_currently_high_bid) {
          FactoryGirl.create(
            :bid,
            auction_id: auction.id,
            amount: 12
          )
        }

        context 'when it is above the current highest bid' do
          it 'returns a hash with success and no message' do
            expect(auction.bid_accepted?(15))
              .to eq({ accepted: true, message: nil })
          end
        end

        context 'when it is at or below current highest bid' do
          it 'returns a hash with fail and a message regarding why' do
            expect(auction.bid_accepted?(10))
              .to eq({ accepted: false, message: "You must submit a bid of 12 or higher" })
          end
        end
      end
    end
  end

end
