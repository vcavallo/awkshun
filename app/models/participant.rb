class Participant < ActiveRecord::Base
  has_many :bids

  def submit_bid(auction, amount)
    return if !auction.live

    result = auction.bid_accepted?(amount)
    if result[:accepted] == true
      self.bids.create(amount: amount, auction_id: auction.id)
      return
    else
      raise result[:message]
    end
  end
end
