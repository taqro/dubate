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

ActiveRecord::Schema.define(version: 2022_04_09_113226) do

  create_table "comments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "debate_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debate_id"], name: "index_comments_on_debate_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "debate_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debate_id"], name: "index_conversations_on_debate_id"
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "debates", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "created_user_id"
    t.integer "joined_user_id"
    t.text "agenda"
    t.boolean "wanted"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "likes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "debate_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debate_id", "user_id"], name: "index_likes_on_debate_id_and_user_id", unique: true
    t.index ["debate_id"], name: "index_likes_on_debate_id"
    t.index ["user_id", "created_at"], name: "index_likes_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "relationships", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.text "profile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "debate_id"
    t.bigint "voted_user_id"
    t.bigint "debating_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debate_id"], name: "index_votes_on_debate_id"
    t.index ["debating_user_id"], name: "index_votes_on_debating_user_id"
    t.index ["voted_user_id"], name: "index_votes_on_voted_user_id"
  end

  create_table "win_or_loses", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "debate_id"
    t.bigint "winner_id"
    t.bigint "loser_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["debate_id"], name: "index_win_or_loses_on_debate_id"
    t.index ["loser_id"], name: "index_win_or_loses_on_loser_id"
    t.index ["winner_id"], name: "index_win_or_loses_on_winner_id"
  end

  add_foreign_key "comments", "debates"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "debates"
  add_foreign_key "conversations", "users"
  add_foreign_key "likes", "debates"
  add_foreign_key "likes", "users"
  add_foreign_key "votes", "debates"
end
