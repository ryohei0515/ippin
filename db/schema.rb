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

ActiveRecord::Schema.define(version: 2021_03_06_001005) do

  create_table "foods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "name_kana"
    t.string "category"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id", "review_id"], name: "index_likes_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
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
    t.string "picture_cc"
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

  create_table "temporary_shops", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "logo_image"
    t.string "name_kana"
    t.string "address"
    t.string "station_name"
    t.integer "ktai_coupon"
    t.string "large_service_area_code"
    t.string "large_service_area_name"
    t.string "service_area_code"
    t.string "service_area_name"
    t.string "large_area_code"
    t.string "large_area_name"
    t.string "middle_area_code"
    t.string "middle_area_name"
    t.string "small_area_code"
    t.string "small_area_name"
    t.float "lat"
    t.float "lng"
    t.string "genre_code"
    t.string "genre_name"
    t.string "genre_catch"
    t.string "sub_genre_code"
    t.string "sub_genre_name"
    t.string "budget_code"
    t.string "budget_name"
    t.string "budget_average"
    t.string "budget_memo"
    t.string "catch"
    t.integer "capacity"
    t.string "access"
    t.string "mobile_access"
    t.string "urls_pc"
    t.string "photo_pc_l"
    t.string "photo_pc_m"
    t.string "photo_pc_s"
    t.string "photo_mobile_l"
    t.string "photo_mobile_s"
    t.string "open"
    t.string "close"
    t.integer "party_capacity"
    t.string "wifi"
    t.string "wedding"
    t.string "course"
    t.string "free_drink"
    t.string "free_food"
    t.string "private_room"
    t.string "horigotatsu"
    t.string "tatami"
    t.string "card"
    t.string "non_smoking"
    t.string "charter"
    t.string "ktai"
    t.string "parking"
    t.string "barrier_free"
    t.string "other_memo"
    t.string "sommelier"
    t.string "open_air"
    t.string "show"
    t.string "equipment"
    t.string "karaoke"
    t.string "band"
    t.string "tv"
    t.string "english"
    t.string "pet"
    t.string "child"
    t.string "lunch"
    t.string "midnight"
    t.string "shop_detail_memo"
    t.string "coupon_urls_pc"
    t.string "coupon_urls_sp"
    t.string "search_keyword"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["search_keyword"], name: "index_temporary_shops_on_search_keyword"
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

  add_foreign_key "likes", "reviews"
  add_foreign_key "likes", "users"
  add_foreign_key "reviews", "shop_foods"
  add_foreign_key "reviews", "users"
  add_foreign_key "shop_foods", "foods"
  add_foreign_key "shop_foods", "shops"
end
