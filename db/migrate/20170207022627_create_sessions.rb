# frozen_string_literal: true
class CreateSessions < ActiveRecord::Migration[5.0]
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.string :authentication_token
      t.timestamp :expires
      t.string :refresh_token
      t.timestamp :refresh_expires

      t.index :authentication_token, unique: true
      t.index :refresh_token, unique: true
      t.index :user_id
    end
  end
end
