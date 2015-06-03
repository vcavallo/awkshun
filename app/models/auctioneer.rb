class Auctioneer < ActiveRecord::Base

  def add_item(item_name, reserved_price)
    Item.create(
      {
        name: item_name,
        reserved_price: reserved_price
      }
    )
  end

  #TODO: this isn't going to be used.
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

    if item && !item.already_sold
      if item.auction #already has an auction
        if item.auction.success.nil? #auction hasn't run yet
          item.auction.go_live!
        else #auction has run, has a status
          #... so start a new auction
          Auction.create(item: item).go_live!
        end
      else # item has no auction at all, create one
        Auction.create(item: item).go_live!
      end
    elsif item && item.already_sold
      raise "That item already sold"
    elsif item.nil?
      raise "There is no item with that name"
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
