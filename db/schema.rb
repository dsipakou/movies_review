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

ActiveRecord::Schema.define(version: 20150206102053) do

  create_table "comments", force: true do |t|
    t.integer  "movie_id"
    t.integer  "parent_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.string   "body"
    t.boolean  "used",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "movies", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "orig_title"
    t.string   "year"
    t.string   "link"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_comments", ["post_id"], name: "index_post_comments_on_post_id", using: :btree
  add_index "post_comments", ["user_id"], name: "index_post_comments_on_user_id", using: :btree

  create_table "post_track_times", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "post_track_times", ["post_id"], name: "index_post_track_times_on_post_id", using: :btree
  add_index "post_track_times", ["user_id"], name: "index_post_track_times_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.integer  "movie_id"
    t.integer  "user_id"
    t.text     "content"
    t.integer  "stars",      default: 0
    t.boolean  "awesome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "track_times", force: true do |t|
    t.integer  "user_id"
    t.integer  "movie_id"
    t.datetime "review_view_time"
    t.datetime "comment_view_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "track_times", ["movie_id"], name: "index_track_times_on_movie_id", using: :btree
  add_index "track_times", ["user_id"], name: "index_track_times_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",        limit: 20
    t.string   "nickname",        limit: 20
    t.string   "password_digest", limit: 70
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
