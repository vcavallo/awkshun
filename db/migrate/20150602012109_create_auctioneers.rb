class CreateAuctioneers < ActiveRecord::Migration
  def change
    create_table :auctioneers do |t|
      t.string :name

      t.timestamps
    end
  end
end
