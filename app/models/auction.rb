class Auction < ActiveRecord::Base
  has_one :item
  has_many :bids

  accepts_nested_attributes_for :item

  def go_live!
    self.update(live: true)
  end

end
