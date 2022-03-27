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

ActiveRecord::Schema[7.0].define(version: 2022_03_27_052939) do
  create_table "favorites", charset: "utf8mb4", comment: "お気に入り", force: :cascade do |t|
    t.bigint "user_id", null: false, comment: "ユーザーID"
    t.bigint "movie_id", null: false, comment: "映画ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_favorites_on_movie_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "genres", charset: "utf8mb4", comment: "ジャンル", force: :cascade do |t|
    t.string "genre_name", null: false, comment: "ジャンル名"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movie_genre_managements", charset: "utf8mb4", comment: "映画ジャンル管理", force: :cascade do |t|
    t.bigint "movie_id", null: false, comment: "映画ID"
    t.bigint "genre_id", null: false, comment: "ジャンルID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_movie_genre_managements_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genre_managements_on_movie_id"
  end

  create_table "movies", charset: "utf8mb4", comment: "映画", force: :cascade do |t|
    t.string "title", null: false, comment: "タイトル名"
    t.text "description", comment: "概要"
    t.string "prod_country", comment: "製作国"
    t.string "director", comment: "監督"
    t.date "release_date", comment: "公開日"
    t.time "running_time", comment: "上映時間"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", charset: "utf8mb4", comment: "ユーザー", force: :cascade do |t|
    t.string "name", limit: 50, null: false, comment: "氏名"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "password_digest", comment: "パスワード"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "favorites", "movies"
  add_foreign_key "favorites", "users"
  add_foreign_key "movie_genre_managements", "genres"
  add_foreign_key "movie_genre_managements", "movies"
end
