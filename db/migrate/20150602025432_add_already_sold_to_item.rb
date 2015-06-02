class AddAlreadySoldToItem < ActiveRecord::Migration
  def change
    add_column :items, :already_sold, :boolean, default: false
  end
end
