class Participant < ActiveRecord::Base
  has_many :bids
end
