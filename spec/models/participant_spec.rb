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
end
