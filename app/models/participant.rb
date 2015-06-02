class Participant < ActiveRecord::Base
  has_many :bids

  def submit_bid(auction, amount)
    result = auction.bid_accepted?(amount)
    if result[:accepted] == true
      return
    else
      raise result[:message]
    end
  end
end
