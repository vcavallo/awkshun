class Auction < ActiveRecord::Base
  has_one :item
  has_many :bids

  accepts_nested_attributes_for :item

  def go_live!
    self.update(live: true)
  end

  def go_dead!
    self.update(live: false)
  end

  def mark_successful
    self.update(success: true)
    self.item.mark_sold
  end

  def mark_unsuccessful
    self.update(success: false)
  end

  def current_max_bid_amount
    self.bids.maximum(:amount)
  end

  def bid_accepted?(amount)
    current_max_bid = self.current_max_bid_amount

    if current_max_bid && amount <= current_max_bid
      { accepted: false, message: "You must submit a bid of #{current_max_bid + 1} or higher" }
    else
      { accepted: true, message: nil }
    end
  end

end
