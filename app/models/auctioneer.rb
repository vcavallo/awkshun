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
    # NOTE: instructions said:
    # "Auctioneer starts an auction on an item"
    # ^ I took this to literally mean that an Item is what is used to initiate
    item = Item.find_by_name(item_name)

    if item
      item.auction.go_live!
    else
      raise "There is no auction for that item name"
    end
  end

  def call_auction!(auction)
    auction.go_dead!

    if auction.current_max_bid_amount >= auction.item.reserved_price
      auction.mark_successful
    else
      auction.mark_unsuccessful
    end
  end

end
