class Bid < ActiveRecord::Base
  validates :amount, numericality: { greater_than_or_equal_to: 1 }

  belongs_to :auction
  belongs_to :participant
end
