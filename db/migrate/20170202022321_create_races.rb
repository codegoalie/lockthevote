class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.string :office, null: false
      t.integer :election_id, null: false
      t.text :description

      t.index :election_id

      t.timestamps
    end
  end
end
