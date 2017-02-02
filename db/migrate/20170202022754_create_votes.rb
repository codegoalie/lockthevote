class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :voter_id, null: false
      t.integer :race_id, null: false
      t.integer :selection_id, null: false

      t.index [:voter_id, :race_id], unique: true
      t.index [:race_id, :selection_id]

      t.timestamps
    end
  end
end
