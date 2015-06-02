class Auctioneer < ActiveRecord::Base

  def create_auction(item_name, reserved_price)
    Auction.create(
      item_attributes: {
        name: item_name,
        reserved_price: reserved_price
      }
    )
  end

  def start_auction!(item_name)
    item = Item.find_by_name(item_name)

    if item
      item.auction.go_live!
    else
      raise "There is no auction for that item name"
    end
  end

end
