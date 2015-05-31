require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "Validations" do
    let(:item) { FactoryGirl.create(:item) }

    it 'has a valid factory' do
      expect(item).to be_valid
    end

    it 'is invalid without a name' do
      item.name = nil
      expect(item).to have(1).error_on(:name)
    end

    it 'is invalid without unique name' do
      item_2 = Item.new(name: item.name)
      expect(item_2).to have(1).error_on(:name)
    end

    it 'is invalid without a reserved_price' do
      item.reserved_price = nil
      expect(item).to have(2).errors_on(:reserved_price)
    end

    it 'is invalid with negative reserved_price' do
      item.reserved_price = -1
      expect(item).to have(1).error_on(:reserved_price)
    end

    it 'is invalid with reserved_price of zero' do
      item.reserved_price = 0
      expect(item).to have(1).error_on(:reserved_price)
    end

  end

  describe "Attributes" do
    # After the above validation specs these aren't really needed,
    # but they work nicely as documentation for someone seeking an overview.
    let(:item) { FactoryGirl.create(:item) }

    it 'has a name' do
      expect(item).to respond_to(:name)
    end

    it 'has a reserved_price' do
      expect(item).to respond_to(:reserved_price)
    end
  end
end
