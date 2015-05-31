class Item < ActiveRecord::Base
  validates :name,
    presence: true,
    uniqueness: true
  validates :reserved_price,
    presence: true,
    numericality: { greater_than_or_equal_to: 1 }

  belongs_to :auction
end
