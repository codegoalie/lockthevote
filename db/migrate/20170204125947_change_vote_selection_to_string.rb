class ChangeVoteSelectionToString < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :selection, :string
    reversible do |dir|
      dir.up do
        execute 'update votes set selection = selection_id'
      end
      dir.down do
        execute 'update votes set selection_id = selection'
      end
    end
    change_column :votes, :selection, :string, null: false
    remove_column :votes, :selection_id, :integer, null: false
  end
end
