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

ActiveRecord::Schema.define(version: 2019_07_18_205128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "billing_token"
  end

  create_table "purchases", force: :cascade do |t|
    t.bigint "subscriber_id"
    t.string "status", null: false
    t.datetime "purchased_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscriber_id"], name: "index_purchases_on_subscriber_id"
  end

  create_table "responses", force: :cascade do |t|
    t.bigint "purchase_id"
    t.string "error_message"
    t.jsonb "response_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["purchase_id"], name: "index_responses_on_purchase_id"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "name", null: false
    t.string "zip_code", null: false
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_shipping_addresses_on_customer_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "subscription_id"
    t.bigint "customer_id"
    t.string "status", null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_subscribers_on_customer_id"
    t.index ["subscription_id"], name: "index_subscribers_on_subscription_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "name", null: false
    t.string "term", null: false
    t.string "status", null: false
    t.integer "price", default: 0, null: false
    t.datetime "purchased_at"
    t.datetime "expires_at"
    t.datetime "terminated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
