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

ActiveRecord::Schema.define(version: 20150925111139) do

  create_table "adventurers", force: :cascade do |t|
    t.text     "name"
    t.integer  "guildhall_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.text     "skills"
    t.boolean  "temp",              default: true
    t.date     "entered_market_at"
  end

  create_table "authem_sessions", force: :cascade do |t|
    t.string   "role",                    null: false
    t.integer  "subject_id",              null: false
    t.string   "subject_type",            null: false
    t.string   "token",        limit: 60, null: false
    t.datetime "expires_at",              null: false
    t.integer  "ttl",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authem_sessions", ["expires_at", "subject_type", "subject_id"], name: "index_authem_sessions_subject"
  add_index "authem_sessions", ["expires_at", "token"], name: "index_authem_sessions_on_expires_at_and_token", unique: true

  create_table "bids", force: :cascade do |t|
    t.integer  "guildhall_id"
    t.integer  "quest_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "contracts", force: :cascade do |t|
    t.integer  "guildhall_id"
    t.integer  "quest_id"
    t.integer  "amount"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "guildhalls", force: :cascade do |t|
    t.text     "name"
    t.integer  "gold"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "capacity"
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "display_name"
    t.string   "about"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  create_table "quest_logs", force: :cascade do |t|
    t.integer  "adventurer_id"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "quests", force: :cascade do |t|
    t.string   "title"
    t.text     "steps"
    t.integer  "guildhall_id",          default: 0
    t.text     "rewards"
    t.date     "deadline"
    t.boolean  "complete",              default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "difficulty_multiplier"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "contract_id"
    t.integer  "adventurer_id"
    t.date     "ends_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "result"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "password_reset_token", limit: 60, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
