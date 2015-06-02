require 'rails_helper'

RSpec.describe Auctioneer, type: :model do
  describe "Features" do
    let(:auctioneer) { FactoryGirl.create(:auctioneer) }

    describe "#create_auction" do
      it 'creates an auction' do
        expect(Auction).to receive(:create)
        auctioneer.create_auction('item name', 200)
      end

      it 'creates an item' do
        auctioneer.create_auction('item name', 200)
        expect(Item.last.name).to eq 'item name'
        expect(Item.last.reserved_price).to eq 200
      end

      it 'adds the item to the auction' do
        auctioneer.create_auction('item name', 200)
        expect(Auction.last.item.name).to eq 'item name'
      end
    end

    describe "#start_auction" do
      let!(:auction_to_start) { FactoryGirl.create(:auction) }
      let!(:item) { FactoryGirl.create(:item, auction_id: auction_to_start.id) }

      it 'finds the auction via unique item name' do
        expect(Item).to receive(:find_by_name)
          .with(item.name)
          .and_return(item)
        auctioneer.start_auction!(item.name)
      end

      context 'when the item is found' do
        it 'tells the auction to go live' do
          expect_any_instance_of(Auction).to receive(:go_live!)
          auctioneer.start_auction!(item.name)
        end
      end

      context 'when the item is NOT found' do
        it 'raises an error' do
          expect { auctioneer.start_auction!('whatthehell?') }
            .to raise_error(RuntimeError, /item name/)
        end
      end
    end

    describe "#call_auction!" do
      let!(:auction) { FactoryGirl.create(:auction, success: nil) }
      let!(:item) {
        FactoryGirl.create(
          :item,
          auction_id: auction.id,
          reserved_price: 100
        )
      }
      let!(:a_low_bid) {
        FactoryGirl.create(
          :bid,
          auction_id: auction.id,
          amount: 5
        )
      }

      it 'ends the auction no matter what' do
        expect(auction).to receive(:go_dead!)
        auctioneer.call_auction!(auction)
      end

      context 'when the reserved price hasn\'t been met' do
        let!(:another_low_bid) {
          FactoryGirl.create(
            :bid,
            auction_id: auction.id,
            amount: 12
          )
        }

        it 'it is marked a failure' do
          auctioneer.call_auction!(auction)
          expect(auction.success).to eq false
        end
      end

      context 'when the reserved price has been met' do
        let!(:another_low_bid) {
          FactoryGirl.create(
            :bid,
            auction_id: auction.id,
            amount: 12
          )
        }

        let!(:a_sufficient_bid) {
          FactoryGirl.create(
            :bid,
            auction_id: auction.id,
            amount: 101
          )
        }

        it 'is marked a success and the item is now unsellable' do
          auctioneer.call_auction!(auction)
          expect(auction.success).to eq true
          expect(Item.last.already_sold).to eq true
        end
      end
    end

  end
end
