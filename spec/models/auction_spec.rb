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
  end

end
