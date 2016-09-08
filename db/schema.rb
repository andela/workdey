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

ActiveRecord::Schema.define(version: 20160829083323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "bids", force: :cascade do |t|
    t.string   "description"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.decimal  "price",       precision: 8
  end

  add_index "bids", ["task_id"], name: "index_bids_on_task_id", using: :btree
  add_index "bids", ["user_id"], name: "index_bids_on_user_id", using: :btree

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

  create_table "references", force: :cascade do |t|
    t.integer  "taskee_id"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "relationship"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.hstore   "skillsets",          default: {},    null: false
    t.string   "confirmation_token",                 null: false
    t.boolean  "done",               default: false
  end

  add_index "references", ["taskee_id"], name: "index_references_on_taskee_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "reviewer_id"
    t.integer  "rating"
    t.string   "review"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "skillsets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "task_managements", force: :cascade do |t|
    t.integer  "task_id"
    t.integer  "tasker_id"
    t.integer  "taskee_id"
    t.string   "description"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "amount"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status",      default: "inactive"
    t.boolean  "paid",        default: false
    t.boolean  "shared",      default: false
  end

  create_table "taskee_skillsets", force: :cascade do |t|
    t.integer  "skillset_id"
    t.integer  "taskee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "taskee_skillsets", ["skillset_id"], name: "index_taskee_skillsets_on_skillset_id", using: :btree
  add_index "taskee_skillsets", ["taskee_id"], name: "index_taskee_skillsets_on_taskee_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "description"
    t.integer  "price"
    t.time     "time"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "tasker_id"
    t.string   "location"
    t.string   "status",                               default: "unassigned"
    t.integer  "skillset_id"
    t.decimal  "latitude",    precision: 10, scale: 6
    t.decimal  "longitude",   precision: 10, scale: 6
    t.integer  "taskee_id"
    t.text     "price_range"
    t.boolean  "broadcasted",                          default: false
  end

  add_index "tasks", ["skillset_id"], name: "index_tasks_on_skillset_id", using: :btree

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
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "enable_notifications", default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "bids", "tasks"
  add_foreign_key "bids", "users"
  add_foreign_key "taskee_skillsets", "skillsets"
  add_foreign_key "tasks", "skillsets"
end
