# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140606225012) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "match_events", force: true do |t|
    t.integer  "match_id"
    t.integer  "seat_id"
    t.integer  "bet_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "pot_cents"
    t.string   "card1",             limit: 2
    t.string   "card2",             limit: 2
    t.string   "card3",             limit: 2
    t.string   "card4",             limit: 2
    t.string   "card5",             limit: 2
    t.integer  "active_seat_id"
    t.integer  "num_cards_showing"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seats", force: true do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.string   "card1",           limit: 2
    t.string   "card2",           limit: 2
    t.integer  "user_pot_cents"
    t.integer  "bet_short_cents"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "last_bet_cents"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.integer  "user_wallet_cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
