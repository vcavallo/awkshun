class AddParticipantIdToBids < ActiveRecord::Migration
  def change
    add_column :bids, :participant_id, :integer
  end
end
