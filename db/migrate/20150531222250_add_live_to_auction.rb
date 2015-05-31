class AddLiveToAuction < ActiveRecord::Migration
  def change
    add_column :auctions, :live, :boolean, default: false
  end
end
