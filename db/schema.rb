# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_27_034843) do

  create_table "foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.string "category"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.float "rate"
    t.bigint "shop_food_id", null: false
    t.string "picture"
    t.index ["shop_food_id"], name: "index_reviews_on_shop_food_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "shop_foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "rate"
    t.bigint "food_id", null: false
    t.string "shop_id", null: false
    t.index ["food_id", "shop_id"], name: "index_shop_foods_on_food_id_and_shop_id", unique: true
    t.index ["food_id"], name: "index_shop_foods_on_food_id"
    t.index ["rate"], name: "index_shop_foods_on_rate"
    t.index ["shop_id"], name: "index_shop_foods_on_shop_id"
  end

  create_table "shops", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "large_area"
    t.string "middle_area"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.string "picture"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "reviews", "shop_foods"
  add_foreign_key "reviews", "users"
  add_foreign_key "shop_foods", "foods"
  add_foreign_key "shop_foods", "shops"
end
