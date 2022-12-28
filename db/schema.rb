# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_12_172021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_games", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "game_id", null: false
    t.boolean "used", default: false
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_card_games_on_card_id"
    t.index ["game_id"], name: "index_card_games_on_game_id"
  end

  create_table "card_players", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "player_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_card_players_on_card_id"
    t.index ["player_id"], name: "index_card_players_on_player_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "type", null: false
    t.string "text", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "pack_id", null: false
    t.integer "pick"
    t.index ["pack_id"], name: "index_cards_on_pack_id"
    t.index ["text"], name: "index_cards_on_text", unique: true
  end

  create_table "games", force: :cascade do |t|
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "max_players", default: 0, null: false
    t.index ["slug"], name: "index_games_on_slug", unique: true
  end

  create_table "options", force: :cascade do |t|
    t.string "code"
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_options_on_game_id"
  end

  create_table "packs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "token", null: false
    t.integer "position"
    t.bigint "game_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "random_seed"
    t.boolean "rando", default: false
    t.boolean "expand_hand", default: false
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["token"], name: "index_players_on_token", unique: true
  end

  create_table "rounds", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "status"
    t.integer "position", null: false
    t.integer "czar_id"
    t.integer "black_card_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_rounds_on_game_id"
  end

  create_table "submissions", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "round_id", null: false
    t.bigint "card_id", null: false
    t.boolean "won", default: false, null: false
    t.integer "position", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_submissions_on_card_id"
    t.index ["player_id"], name: "index_submissions_on_player_id"
    t.index ["round_id"], name: "index_submissions_on_round_id"
  end

  add_foreign_key "card_games", "cards"
  add_foreign_key "card_games", "games"
  add_foreign_key "card_players", "cards"
  add_foreign_key "card_players", "players"
  add_foreign_key "cards", "packs"
  add_foreign_key "options", "games"
  add_foreign_key "players", "games"
  add_foreign_key "rounds", "games"
  add_foreign_key "submissions", "cards"
  add_foreign_key "submissions", "players"
  add_foreign_key "submissions", "rounds"
end
