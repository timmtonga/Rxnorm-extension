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

ActiveRecord::Schema.define(version: 20180311145543) do

  create_table "batch_jobs", primary_key: "job_id", force: :cascade do |t|
    t.string   "batch_name", limit: 255, null: false
    t.string   "status",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "local_concepts", force: :cascade do |t|
    t.string   "RXCUI",      limit: 255
    t.string   "LAT",        limit: 255
    t.string   "TS",         limit: 255
    t.string   "LUI",        limit: 255
    t.string   "STT",        limit: 255
    t.string   "SUI",        limit: 255
    t.string   "ISPREF",     limit: 255
    t.string   "RXAUI",      limit: 255
    t.string   "SAUI",       limit: 255
    t.string   "SCUI",       limit: 255
    t.string   "SDUI",       limit: 255
    t.string   "SAB",        limit: 255
    t.string   "TTY",        limit: 255
    t.string   "CODE",       limit: 255
    t.string   "STR",        limit: 255
    t.string   "SRL",        limit: 255
    t.string   "SUPPRESS",   limit: 255
    t.string   "CVF",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "local_relationships", force: :cascade do |t|
    t.string   "RXCUI1",     limit: 255
    t.string   "RXAUI1",     limit: 255
    t.string   "STYPE1",     limit: 255
    t.string   "REL",        limit: 255
    t.string   "RXCUI2",     limit: 255
    t.string   "RXAUI2",     limit: 255
    t.string   "STYPE2",     limit: 255
    t.string   "RELA",       limit: 255
    t.string   "RUI",        limit: 255
    t.string   "SRUI",       limit: 255
    t.string   "SAB",        limit: 255
    t.string   "SL",         limit: 255
    t.string   "DIR",        limit: 255
    t.string   "RG",         limit: 255
    t.string   "SUPPRESS",   limit: 255
    t.string   "CVF",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "local_sats", force: :cascade do |t|
    t.string   "RXCUI",      limit: 255
    t.string   "LUI",        limit: 255
    t.string   "SUI",        limit: 255
    t.string   "RXAUI",      limit: 255
    t.string   "STYPE",      limit: 255
    t.string   "CODE",       limit: 255
    t.string   "ATUI",       limit: 255
    t.string   "SATUI",      limit: 255
    t.string   "ATN",        limit: 255
    t.string   "SAB",        limit: 255
    t.string   "ATV",        limit: 255
    t.string   "SUPPRESS",   limit: 255
    t.string   "CVF",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "phonetic_codes", force: :cascade do |t|
    t.string   "RXCUI",      limit: 255
    t.string   "RXAUI",      limit: 255
    t.text     "STR",        limit: 65535
    t.text     "soundex",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "search_items", primary_key: "search_item_id", force: :cascade do |t|
    t.integer  "job_id",            limit: 4,   null: false
    t.string   "search_term",       limit: 255, null: false
    t.string   "potential_matches", limit: 255
    t.string   "confirmed_matches", limit: 255
    t.string   "match_method",      limit: 255
    t.string   "status",            limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", primary_key: "user_id", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
