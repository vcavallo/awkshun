This is a simple backend library for an auction system. It has a few features written to satisfy the five requested requirements outlined below.

1. Auctioneer adds an item that can be auctioned. An item has a unique name and reserved price
    - `auctioneer#add_item(item_name, reserved_price)`

2. Auctioneer starts an auction on an item
    - `auctioneer#start_auction!(item_name)`

3. Participants submit bids to an auction, a new bid has to have a price higher than the current highest bid otherwise it's not allowed.
    - `participant#submit_bid(auction_object, bid_amount)`

4. Auctioneer calls the auction (when s/he makes the judgement on her own that there will be no more higher bids coming in). If the current highest bid is higher than the reserved price of the item, the auction is deemed as a success otherwise it's marked as failure. The item sold should be no longer available for future auctions.
    - `auctioneer#call_auction!(auction_object)`

5. Participant/Auctioneer queries the latest action of an item by item name. The library should return the status of the auction if there is any, if the item is sold, it should return the information regarding the price sold and to whom it was sold to.
    - `Item::status_by_name(item_name)`

**Some methods use the `item_name` and some use the `auction` object. This was done to follow the assignments requests to the letter. Otherwise, I would normalize this interface.**

Sample run-through:

- `$ bundle install`
- `$ rspec -f doc`
- ...
- `$ rake db:create`
- `$ rake db:migrate`
- `$ rails c`
- `a = Auctioneer.create`
- `a.add_item("vase", 10)`
- `a.start_auction!("vase")`
- `p = Participant.create(name: "chuck")`
- `vase_auction = Item.find_by(name: "vase")`
- `p.submit_bid(vase_auction, 5)`
- `Item::status_by_name("vase")`

    ```
    => {
        "auction status"=>{
          "success?"=>nil,
          "live?"=>true
        },
        "bid details"=>{
          "high bid amount"=>5,
          "high bidder"=>"chuck"
        }
      }
    ```
- `a.call_auction!(vase_auction)`
- `Item::status_by_name("vase")`

    ```
    => {
        "auction status"=>{
          "success?"=>false,
          "live?"=>false
        },
        "bid details"=>{
          "high bid amount"=>5,
          "high bidder"=>"chuck"
        }
      }
    ```
- success? is false because reserve was not met
