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

ActiveRecord::Schema.define(version: 20171112214540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.bigint "location_id"
    t.bigint "category_id"
    t.string "contact_name"
    t.string "contact_phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "business_type"
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
  end

  create_table "images", force: :cascade do |t|
    t.bigint "experience_id"
    t.text "file"
    t.string "image_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["experience_id"], name: "index_images_on_experience_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "business_id"
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

  add_foreign_key "businesses", "categories"
  add_foreign_key "businesses", "locations"
  add_foreign_key "experience_ideas", "categories"
  add_foreign_key "experience_occurances", "experiences"
  add_foreign_key "images", "experiences"
  add_foreign_key "locations", "businesses"
  add_foreign_key "reservations", "experience_occurances"
  add_foreign_key "reservations", "experiences"
end
