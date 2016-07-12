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

ActiveRecord::Schema.define(version: 20160620143915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bid_managements", force: :cascade do |t|
    t.integer  "bidding_id"
    t.integer  "taskee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "bid_managements", ["bidding_id"], name: "index_bid_managements_on_bidding_id", using: :btree

  create_table "biddings", force: :cascade do |t|
    t.integer  "task_id"
    t.text     "description"
    t.string   "price_range"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "tasker_id"
    t.string   "name"
  end

  add_index "biddings", ["task_id"], name: "index_biddings_on_task_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "message"
    t.boolean  "read",            default: false
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "user_notified",   default: false
    t.integer  "notifiable_id"
    t.string   "notifiable_type"
  end

  add_index "notifications", ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id", using: :btree
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reviewer_id"
    t.integer  "rating"
    t.string   "review"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skillsets", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "task_managements", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "tasker_id"
    t.integer  "taskee_id"
    t.string   "task_desc"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "amount"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status",     default: "inactive"
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_plans", force: :cascade do |t|
    t.string   "name"
    t.date     "active_until"
    t.integer  "user_id"
    t.integer  "tasks_counter", default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "gender"
    t.date     "birthday"
    t.string   "phone"
    t.string   "password_digest"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "user_type"
    t.string   "provider"
    t.string   "oauth_id"
    t.string   "confirm_token"
    t.boolean  "confirmed",            default: false
    t.string   "state"
    t.string   "city"
    t.string   "street_address"
    t.string   "image_url"
    t.boolean  "has_taken_quiz",       default: false
    t.boolean  "enable_notifications", default: true
    t.float    "longitude"
    t.float    "latitude"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "bid_managements", "biddings"
  add_foreign_key "biddings", "tasks"
end
