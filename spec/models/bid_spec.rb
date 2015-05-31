require 'rails_helper'

RSpec.describe Bid, type: :model do
  describe "Validations" do
    let(:bid) { FactoryGirl.create(:bid) }

    it 'has a valid factory' do
      expect(bid).to be_valid
    end

    it 'is invalid without a positive amount' do
      bid.amount = -1
      expect(bid).to have(1).error_on(:amount)

      bid.amount = 0
      expect(bid).to have(1).error_on(:amount)
    end
  end

  describe "Attributes" do
    let(:bid) { FactoryGirl.create(:bid) }

    it 'has an amount' do
      expect(bid).to respond_to(:amount)
    end
  end

  describe "Associations" do
    let(:bid) { FactoryGirl.create(:bid) }

    it 'belongs to an auction' do
      expect(bid).to belong_to(:auction)
    end

    it 'belongs to a participant' do
      expect(bid).to belong_to(:participant)
    end
  end
end
