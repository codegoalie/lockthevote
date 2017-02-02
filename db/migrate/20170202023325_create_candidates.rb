class CreateCandidates < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :name, null: false
      t.integer :race_id, null: false

      t.index :race_id

      t.timestamps
    end
  end
end
