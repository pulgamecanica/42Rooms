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

ActiveRecord::Schema[7.0].define(version: 2022_05_10_142231) do
  create_table "campus", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "language"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "beginnig"
    t.datetime "ending"
    t.string "subject"
    t.boolean "finished", default: false
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reservations_on_room_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "campus_id", null: false
    t.integer "room_type", default: 0
    t.integer "status", default: 0
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campus_id"], name: "index_rooms_on_campus_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.string "login"
    t.integer "campus_id"
    t.index ["campus_id"], name: "index_users_on_campus_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "white_lists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_white_lists_on_room_id"
    t.index ["user_id"], name: "index_white_lists_on_user_id"
  end

  add_foreign_key "reservations", "rooms"
  add_foreign_key "reservations", "users"
  add_foreign_key "rooms", "campus", column: "campus_id"
  add_foreign_key "users", "campus", column: "campus_id"
  add_foreign_key "white_lists", "rooms"
  add_foreign_key "white_lists", "users"
end
