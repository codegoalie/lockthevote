class CreateElections < ActiveRecord::Migration[5.0]
  def change
    create_table :elections do |t|
      t.string :name, null: false
      t.timestamp :starts_at, null: false
      t.timestamp :ends_at, null: false

      t.index [:starts_at, :ends_at]

      t.timestamps
    end
  end
end
