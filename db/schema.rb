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

ActiveRecord::Schema.define(version: 20180108203312) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "business_settings", force: :cascade do |t|
    t.boolean "ride_request_active"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "play_sound"
  end

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.bigint "location_id"
    t.bigint "category_id"
    t.string "contact_name"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "business_type"
    t.string "website"
    t.index ["category_id"], name: "index_businesses_on_category_id"
    t.index ["location_id"], name: "index_businesses_on_location_id"
  end

  create_table "businesses_experiences", id: false, force: :cascade do |t|
    t.bigint "experience_id", null: false
    t.bigint "business_id", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.bigint "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_experiences", id: false, force: :cascade do |t|
    t.bigint "experience_id", null: false
    t.bigint "category_id", null: false
  end

  create_table "experience_ideas", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.bigint "category_id"
    t.integer "capacity"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_experience_ideas_on_category_id"
  end

  create_table "experience_occurances", force: :cascade do |t|
    t.bigint "experience_id"
    t.date "date"
    t.integer "capacity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_experience_occurances_on_experience_id"
  end

  create_table "experiences", force: :cascade do |t|
    t.string "title"
    t.integer "duration"
    t.integer "capacity"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cost"
    t.date "start_date"
    t.date "end_date"
    t.string "recurrs_every"
    t.text "header_image"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "experience_id"
    t.text "file"
    t.string "image_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_images_on_experience_id"
  end

  create_table "kill_switches", force: :cascade do |t|
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
    t.float "latitude"
    t.float "longitude"
    t.text "instruction"
    t.integer "priority"
    t.index ["business_id"], name: "index_locations_on_business_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.bigint "experience_id"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.bigint "experience_occurance_id"
    t.boolean "paid"
    t.bigint "charge_id"
    t.boolean "deposit_paid"
    t.index ["experience_id"], name: "index_reservations_on_experience_id"
    t.index ["experience_occurance_id"], name: "index_reservations_on_experience_occurance_id"
  end

  create_table "ride_requests", force: :cascade do |t|
    t.string "pickup_address"
    t.string "dropoff_address"
    t.integer "riders"
    t.string "requester_name"
    t.bigint "shuttle_id"
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.string "phone"
    t.text "note"
    t.string "origin"
    t.index ["shuttle_id"], name: "index_ride_requests_on_shuttle_id"
  end

  create_table "shuttle_stops", force: :cascade do |t|
    t.bigint "shuttle_id"
    t.integer "order"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.integer "person_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shuttle_id"], name: "index_shuttle_stops_on_shuttle_id"
  end

  create_table "shuttles", force: :cascade do |t|
    t.float "current_lat"
    t.float "current_long"
    t.float "previous_lat"
    t.float "previous_long"
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity"
    t.string "plate_number"
    t.boolean "is_looping"
    t.datetime "clear_time"
    t.boolean "is_active"
  end

  create_table "trackers", force: :cascade do |t|
    t.bigint "shuttle_id"
    t.float "lat"
    t.float "long"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shuttle_id"], name: "index_trackers_on_shuttle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "businesses", "categories"
  add_foreign_key "businesses", "locations"
  add_foreign_key "experience_ideas", "categories"
  add_foreign_key "experience_occurances", "experiences"
  add_foreign_key "images", "experiences"
  add_foreign_key "locations", "businesses"
  add_foreign_key "reservations", "experience_occurances"
  add_foreign_key "reservations", "experiences"
  add_foreign_key "ride_requests", "shuttles"
  add_foreign_key "shuttle_stops", "shuttles"
  add_foreign_key "trackers", "shuttles"
end
