# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161124155336) do

  create_table "articles", force: :cascade do |t|
    t.text     "content"
    t.string   "user_id"
    t.string   "thumbnail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "article_id"
    t.integer  "question_id"
    t.integer  "comment_id"
    t.integer  "points"
  end

  create_table "comments_points", force: :cascade do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "vote"
  end

  add_index "comments_points", ["user_id", "comment_id"], name: "index_comments_points_on_user_id_and_comment_id", unique: true

  create_table "messages", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "from_id"
    t.integer  "to_id"
    t.boolean  "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plan_requests", force: :cascade do |t|
    t.string   "gender"
    t.float    "weight"
    t.float    "height"
    t.integer  "age"
    t.string   "want_to"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "unit"
    t.integer  "user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "is_admin"
    t.integer  "points"
  end

  create_table "videos", force: :cascade do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "views"
    t.string   "thumbnail"
    t.boolean  "featured"
    t.string   "video_id"
  end

end
