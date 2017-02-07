# frozen_string_literal: true
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_170_207_022_627) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'candidates', force: :cascade do |t|
    t.string   'name',        null: false
    t.integer  'race_id',     null: false
    t.datetime 'created_at',  null: false
    t.datetime 'updated_at',  null: false
    t.text     'description'
    t.index ['race_id'], name: 'index_candidates_on_race_id', using: :btree
  end

  create_table 'elections', force: :cascade do |t|
    t.string   'name',       null: false
    t.datetime 'starts_at',  null: false
    t.datetime 'ends_at',    null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w(starts_at ends_at), name: 'index_elections_on_starts_at_and_ends_at', using: :btree
  end

  create_table 'races', force: :cascade do |t|
    t.string   'office',                       null: false
    t.integer  'election_id',                  null: false
    t.text     'description'
    t.datetime 'created_at',                   null: false
    t.datetime 'updated_at',                   null: false
    t.string   'type', default: 'Race', null: false
    t.index ['election_id'], name: 'index_races_on_election_id', using: :btree
  end

  create_table 'sessions', force: :cascade do |t|
    t.integer  'user_id'
    t.string   'authentication_token'
    t.datetime 'expires'
    t.string   'refresh_token'
    t.datetime 'refresh_expires'
    t.index ['authentication_token'], name: 'index_sessions_on_authentication_token', unique: true, using: :btree
    t.index ['refresh_token'], name: 'index_sessions_on_refresh_token', unique: true, using: :btree
    t.index ['user_id'], name: 'index_sessions_on_user_id', using: :btree
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet     'current_sign_in_ip'
    t.inet     'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
    t.index ['email'], name: 'index_users_on_email', unique: true, using: :btree
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true, using: :btree
  end

  create_table 'votes', force: :cascade do |t|
    t.integer  'voter_id',                    null: false
    t.integer  'race_id',                     null: false
    t.datetime 'created_at',                  null: false
    t.datetime 'updated_at',                  null: false
    t.string   'selection',                   null: false
    t.string   'type', default: 'Vote'
    t.index %w(voter_id race_id), name: 'index_votes_on_voter_id_and_race_id', unique: true, using: :btree
  end
end
