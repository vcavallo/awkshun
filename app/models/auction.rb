class Auction < ActiveRecord::Base
  has_one :item
  has_many :bids

  accepts_nested_attributes_for :item

  def go_live!
    self.update(live: true)
  end

  def bid_accepted?(amount)
    current_max_bid = self.bids.maximum(:amount)
    if amount > current_max_bid
      { accepted: true, message: nil }
    else
      { accepted: false, message: "You must submit a bid of #{current_max_bid} or higher" }
    end
  end

end
