# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170202022754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "elections", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "starts_at",  null: false
    t.datetime "ends_at",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["starts_at", "ends_at"], name: "index_elections_on_starts_at_and_ends_at", using: :btree
  end

  create_table "races", force: :cascade do |t|
    t.string   "office",      null: false
    t.integer  "election_id", null: false
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["election_id"], name: "index_races_on_election_id", using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "voter_id",     null: false
    t.integer  "race_id",      null: false
    t.integer  "selection_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["race_id", "selection_id"], name: "index_votes_on_race_id_and_selection_id", using: :btree
    t.index ["voter_id", "race_id"], name: "index_votes_on_voter_id_and_race_id", unique: true, using: :btree
  end

end
