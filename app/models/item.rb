class Item < ActiveRecord::Base
  validates :name,
    presence: true,
    uniqueness: true
  validates :reserved_price,
    presence: true,
    numericality: { greater_than_or_equal_to: 1 }

  belongs_to :auction

  def mark_sold
    self.update(already_sold: true)
  end

  def self.status_by_name(item_name)
    item = Item.find_by_name(item_name)

    if item
      {
        "auction status" => item.auction_status || "no auction for this item",
        "bid details" => item.bid_details || "no bids yet"
      }
    else
      { "query result" => "no item found with that name" }
    end
  end

  def auction_status
    if self.auction
      {
        "success?" => auction.success,
        "live?" => auction.live
      }
    end
  end

  def bid_details
    if self.auction
      bids = self.auction.bids
      if bids.present?
        high_bid = bids.order(amount: :desc).first
        {
          "high bid amount" => high_bid.amount,
          "high bidder" => high_bid.participant.name
        }
      end
    end
  end

end
