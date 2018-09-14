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

ActiveRecord::Schema.define(version: 2018_09_12_210805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "spotify_fetches", force: :cascade do |t|
    t.string "business_name"
    t.string "artist_name"
    t.string "song_name"
    t.string "full_url"
    t.string "prev_url"
    t.string "album_cover"
    t.string "album_cover_sm"
    t.string "album_name"
    t.bigint "yelp_fetch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["yelp_fetch_id"], name: "index_spotify_fetches_on_yelp_fetch_id"
  end

  create_table "yelp_fetches", force: :cascade do |t|
    t.string "location"
    t.string "search_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
