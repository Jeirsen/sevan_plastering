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

ActiveRecord::Schema.define(version: 20180328180229) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "builders", force: :cascade do |t|
    t.string "name"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lots", force: :cascade do |t|
    t.string "name"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
    t.bigint "model_id"
    t.string "number"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.index ["model_id"], name: "index_lots_on_model_id"
    t.index ["project_id"], name: "index_lots_on_project_id"
  end

  create_table "models", force: :cascade do |t|
    t.bigint "builder_id"
    t.string "name"
    t.string "url_model_image"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.index ["builder_id"], name: "index_models_on_builder_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.decimal "price", precision: 5, scale: 2
    t.decimal "total", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "order_numbers", force: :cascade do |t|
    t.integer "order_number"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "order_number"
    t.datetime "delivery_date"
    t.bigint "project_id"
    t.integer "time_needed_by"
    t.bigint "lot_id"
    t.integer "status", default: 0
    t.bigint "vendor_id"
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "order_total", precision: 5, scale: 2
    t.bigint "user_id"
    t.index ["lot_id"], name: "index_orders_on_lot_id"
    t.index ["project_id"], name: "index_orders_on_project_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
    t.index ["vendor_id"], name: "index_orders_on_vendor_id"
  end

  create_table "product_vendors", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "vendor_id"
    t.decimal "price", precision: 5, scale: 2
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_vendors_on_product_id"
    t.index ["vendor_id"], name: "index_product_vendors_on_vendor_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.bigint "unit_id"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_products_on_unit_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.bigint "builder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["builder_id"], name: "index_projects_on_builder_id"
  end

  create_table "templates", force: :cascade do |t|
    t.bigint "model_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["model_id"], name: "index_templates_on_model_id"
    t.index ["product_id"], name: "index_templates_on_product_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "role", default: 0
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vendor_emails", force: :cascade do |t|
    t.string "description"
    t.string "email"
    t.string "name"
    t.integer "status", default: 1
    t.bigint "vendor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vendor_id"], name: "index_vendor_emails_on_vendor_id"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "address1"
    t.string "address2"
    t.string "state"
    t.string "zipcode"
    t.string "city"
    t.string "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 1
  end

  add_foreign_key "lots", "models"
  add_foreign_key "lots", "projects"
  add_foreign_key "models", "builders"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "lots"
  add_foreign_key "orders", "projects"
  add_foreign_key "orders", "vendors"
  add_foreign_key "product_vendors", "products"
  add_foreign_key "product_vendors", "vendors"
  add_foreign_key "products", "units"
  add_foreign_key "projects", "builders"
  add_foreign_key "templates", "models"
  add_foreign_key "templates", "products"
  add_foreign_key "vendor_emails", "vendors"
end
