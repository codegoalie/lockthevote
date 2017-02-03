class AddDescriptionToCandidates < ActiveRecord::Migration[5.0]
  def change
    add_column :candidates, :description, :text
  end
end
