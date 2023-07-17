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

ActiveRecord::Schema[7.0].define(version: 2023_07_17_171025) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.index ["email"], name: "index_administrators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
  end

  create_table "aproveds", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.integer "user_id", null: false
    t.date "date_aproved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_aproveds_on_lot_id"
    t.index ["user_id"], name: "index_aproveds_on_user_id"
  end

  create_table "bids", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.integer "user_id", null: false
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_bids_on_lot_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "blocked_cpfs", force: :cascade do |t|
    t.integer "user_id"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_blocked_cpfs_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_favorites_on_lot_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "finalizeds", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_finalizeds_on_lot_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "url_img"
    t.integer "weight"
    t.integer "height"
    t.integer "width"
    t.integer "depth"
    t.string "code"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "selected", default: false
    t.index ["category_id"], name: "index_items_on_category_id"
  end

  create_table "lot_items", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_id", null: false
    t.index ["lot_id"], name: "index_lot_items_on_lot_id"
    t.index ["product_id"], name: "index_lot_items_on_product_id"
  end

  create_table "lots", force: :cascade do |t|
    t.string "code"
    t.date "start_date"
    t.date "limit_date"
    t.decimal "min_value"
    t.decimal "dif_value"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "administrator_id"
  end

  create_table "prod_categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "cod"
    t.string "name"
    t.integer "width"
    t.integer "height"
    t.integer "weight"
    t.integer "depth"
    t.integer "status"
    t.integer "prod_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prod_category_id"], name: "index_products_on_prod_category_id"
  end

  create_table "solds", force: :cascade do |t|
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_solds_on_item_id"
  end

  create_table "user_messages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "from_email"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.string "title"
    t.index ["user_id"], name: "index_user_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cpf"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "winners", force: :cascade do |t|
    t.integer "lot_id", null: false
    t.integer "user_id", null: false
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lot_id"], name: "index_winners_on_lot_id"
    t.index ["user_id"], name: "index_winners_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aproveds", "lots"
  add_foreign_key "aproveds", "users"
  add_foreign_key "bids", "lots"
  add_foreign_key "bids", "users"
  add_foreign_key "blocked_cpfs", "users"
  add_foreign_key "favorites", "lots"
  add_foreign_key "favorites", "users"
  add_foreign_key "finalizeds", "lots"
  add_foreign_key "items", "prod_categories", column: "category_id"
  add_foreign_key "lot_items", "lots"
  add_foreign_key "lot_items", "products"
  add_foreign_key "products", "prod_categories"
  add_foreign_key "solds", "items"
  add_foreign_key "user_messages", "users"
  add_foreign_key "winners", "lots"
  add_foreign_key "winners", "users"
end
