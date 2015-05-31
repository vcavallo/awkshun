class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.boolean :success

      t.timestamps
    end
  end
end
