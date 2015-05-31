class Auction < ActiveRecord::Base
  has_one :item
  has_many :bids
end
