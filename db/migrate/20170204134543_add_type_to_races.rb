class AddTypeToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :type, :string, null: false, default: 'Race'
  end
end
