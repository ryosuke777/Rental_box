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

ActiveRecord::Schema.define(version: 2021_03_23_035908) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bring_in_equipments", force: :cascade do |t|
    t.string "name"
    t.integer "power_consumption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "power_consumption_option"
    t.integer "amount"
    t.integer "group_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "group_id"
    t.integer "item_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gas_requests", force: :cascade do |t|
    t.integer "gase_id"
    t.integer "group_id"
    t.integer "gas_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gases", force: :cascade do |t|
    t.string "name"
    t.integer "amount"
    t.integer "price"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.boolean "is_active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "group_name"
    t.string "group_name_kana"
    t.string "representative_name"
    t.string "representative_name_kana"
    t.string "representative_telephone_number"
    t.string "subdelegate_name"
    t.string "subdelegate_name_kana"
    t.string "subdelegate_telephone_number"
    t.string "subdelegate_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_groups_on_email", unique: true
    t.index ["reset_password_token"], name: "index_groups_on_reset_password_token", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.integer "genre_id"
    t.string "name"
    t.string "image_id"
    t.text "introduction"
    t.integer "price"
    t.integer "add_price"
    t.integer "power_consumption"
    t.float "fuel_economy"
    t.boolean "video"
    t.string "video_url"
    t.boolean "manual"
    t.string "manual_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "power_consumption_option"
    t.boolean "fuel_economy_option"
  end

  create_table "order_gases", force: :cascade do |t|
    t.integer "gase_id"
    t.integer "request_id"
    t.integer "price"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "item_id"
    t.integer "request_id"
    t.integer "price"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "request_bring_in_equipments", force: :cascade do |t|
    t.integer "request_id"
    t.string "name"
    t.integer "power_consumption"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "group_id"
    t.string "item_for_sale"
    t.integer "date"
    t.integer "total_payment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
  end

end
