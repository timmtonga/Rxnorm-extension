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

ActiveRecord::Schema.define(version: 20171120200610) do

  create_table "RXNATOMARCHIVE", id: false, force: :cascade do |t|
    t.string "RXAUI",             limit: 8,    null: false
    t.string "AUI",               limit: 10
    t.string "STR",               limit: 4000, null: false
    t.string "ARCHIVE_TIMESTAMP", limit: 280,  null: false
    t.string "CREATED_TIMESTAMP", limit: 280,  null: false
    t.string "UPDATED_TIMESTAMP", limit: 280,  null: false
    t.string "CODE",              limit: 50
    t.string "IS_BRAND",          limit: 1
    t.string "LAT",               limit: 3
    t.string "LAST_RELEASED",     limit: 30
    t.string "SAUI",              limit: 50
    t.string "VSAB",              limit: 40
    t.string "RXCUI",             limit: 8
    t.string "SAB",               limit: 20
    t.string "TTY",               limit: 20
    t.string "MERGED_TO_RXCUI",   limit: 8
  end

  create_table "RXNCONSO", id: false, force: :cascade do |t|
    t.string "RXCUI",    limit: 8,                    null: false
    t.string "LAT",      limit: 3,    default: "ENG", null: false
    t.string "TS",       limit: 1
    t.string "LUI",      limit: 8
    t.string "STT",      limit: 3
    t.string "SUI",      limit: 8
    t.string "ISPREF",   limit: 1
    t.string "RXAUI",    limit: 8,                    null: false
    t.string "SAUI",     limit: 50
    t.string "SCUI",     limit: 50
    t.string "SDUI",     limit: 50
    t.string "SAB",      limit: 20,                   null: false
    t.string "TTY",      limit: 20,                   null: false
    t.string "CODE",     limit: 50,                   null: false
    t.string "STR",      limit: 3000,                 null: false
    t.string "SRL",      limit: 10
    t.string "SUPPRESS", limit: 1
    t.string "CVF",      limit: 50
  end

  create_table "RXNCUI", id: false, force: :cascade do |t|
    t.string "cui1",        limit: 8
    t.string "ver_start",   limit: 40
    t.string "ver_end",     limit: 40
    t.string "cardinality", limit: 8
    t.string "cui2",        limit: 8
  end

  create_table "RXNCUICHANGES", id: false, force: :cascade do |t|
    t.string "RXAUI",     limit: 8
    t.string "CODE",      limit: 50
    t.string "SAB",       limit: 20
    t.string "TTY",       limit: 20
    t.string "STR",       limit: 3000
    t.string "OLD_RXCUI", limit: 8,    null: false
    t.string "NEW_RXCUI", limit: 8,    null: false
  end

  create_table "RXNDOC", id: false, force: :cascade do |t|
    t.string "DOCKEY", limit: 50,   null: false
    t.string "VALUE",  limit: 1000
    t.string "TYPE",   limit: 50,   null: false
    t.string "EXPL",   limit: 1000
  end

  create_table "RXNREL", id: false, force: :cascade do |t|
    t.string "RXCUI1",   limit: 8
    t.string "RXAUI1",   limit: 8
    t.string "STYPE1",   limit: 50
    t.string "REL",      limit: 4
    t.string "RXCUI2",   limit: 8
    t.string "RXAUI2",   limit: 8
    t.string "STYPE2",   limit: 50
    t.string "RELA",     limit: 100
    t.string "RUI",      limit: 10
    t.string "SRUI",     limit: 50
    t.string "SAB",      limit: 20,   null: false
    t.string "SL",       limit: 1000
    t.string "DIR",      limit: 1
    t.string "RG",       limit: 10
    t.string "SUPPRESS", limit: 1
    t.string "CVF",      limit: 50
  end

  create_table "RXNSAB", id: false, force: :cascade do |t|
    t.string  "VCUI",   limit: 8
    t.string  "RCUI",   limit: 8
    t.string  "VSAB",   limit: 40
    t.string  "RSAB",   limit: 20,   null: false
    t.string  "SON",    limit: 3000
    t.string  "SF",     limit: 20
    t.string  "SVER",   limit: 20
    t.string  "VSTART", limit: 10
    t.string  "VEND",   limit: 10
    t.string  "IMETA",  limit: 10
    t.string  "RMETA",  limit: 10
    t.string  "SLC",    limit: 1000
    t.string  "SCC",    limit: 1000
    t.integer "SRL",    limit: 4
    t.integer "TFR",    limit: 4
    t.integer "CFR",    limit: 4
    t.string  "CXTY",   limit: 50
    t.string  "TTYL",   limit: 300
    t.string  "ATNL",   limit: 1000
    t.string  "LAT",    limit: 3
    t.string  "CENC",   limit: 20
    t.string  "CURVER", limit: 1
    t.string  "SABIN",  limit: 1
    t.string  "SSN",    limit: 3000
    t.string  "SCIT",   limit: 4000
  end

  create_table "RXNSAT", id: false, force: :cascade do |t|
    t.string "RXCUI",    limit: 8
    t.string "LUI",      limit: 8
    t.string "SUI",      limit: 8
    t.string "RXAUI",    limit: 9
    t.string "STYPE",    limit: 50
    t.string "CODE",     limit: 50
    t.string "ATUI",     limit: 11
    t.string "SATUI",    limit: 50
    t.string "ATN",      limit: 1000, null: false
    t.string "SAB",      limit: 20,   null: false
    t.string "ATV",      limit: 4000
    t.string "SUPPRESS", limit: 1
    t.string "CVF",      limit: 50
  end

  create_table "RXNSTY", id: false, force: :cascade do |t|
    t.string "RXCUI", limit: 8,   null: false
    t.string "TUI",   limit: 4
    t.string "STN",   limit: 100
    t.string "STY",   limit: 50
    t.string "ATUI",  limit: 11
    t.string "CVF",   limit: 50
  end

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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "local_relationships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "local_sats", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_items", primary_key: "search_item_id", force: :cascade do |t|
    t.integer  "job_id",            limit: 4,   null: false
    t.string   "search_term",       limit: 255, null: false
    t.string   "potential_matches", limit: 255
    t.string   "confirmed_matches", limit: 255
    t.string   "status",            limit: 255, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
