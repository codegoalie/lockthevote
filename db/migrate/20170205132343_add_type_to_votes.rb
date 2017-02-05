class AddTypeToVotes < ActiveRecord::Migration[5.0]
  def change
    add_column :votes, :type, :string, nill: false, default: 'Vote'
  end
end
