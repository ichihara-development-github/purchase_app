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

ActiveRecord::Schema.define(version: 20201004064029) do

  create_table "baskets", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_baskets_on_product_id"
    t.index ["user_id"], name: "index_baskets_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.float "star"
    t.string "comment"
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_evaluations_on_product_id"
    t.index ["user_id"], name: "index_evaluations_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follow_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "active_user_id"
    t.integer "passive_user_id"
    t.integer "product_id"
    t.integer "comment_id"
    t.boolean "checked", default: false
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.integer "user_id"
    t.string "currency"
    t.integer "payments"
    t.string "email"
    t.string "description"
    t.integer "customer_id"
    t.date "payment_date"
    t.integer "charge_id"
    t.integer "commission"
    t.integer "profit_after_subtract_commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.string "category"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "main_image"
    t.string "sub_image1"
    t.string "sub_image2"
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_purchases_on_product_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "following_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["following_id", "followed_id"], name: "index_relationships_on_following_id_and_followed_id", unique: true
    t.index ["following_id"], name: "index_relationships_on_following_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "top_image"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.text "introduce"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.boolean "seller"
    t.string "profile_image"
    t.string "password_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.index ["store_id"], name: "index_users_on_store_id"
  end

end
