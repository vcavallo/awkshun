class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :reserved_price

      t.timestamps
    end
  end
end
