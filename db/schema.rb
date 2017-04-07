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

ActiveRecord::Schema.define(version: 20170402082635) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_auth_tokens", force: :cascade do |t|
    t.string   "token"
    t.datetime "last_used"
  end

  add_index "api_auth_tokens", ["token"], name: "index_api_auth_tokens_on_token", unique: true, using: :btree

  create_table "report_photos", force: :cascade do |t|
    t.string   "uuid"
    t.string   "public_url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "report_types", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "validate_plate", default: false
  end

  create_table "reports", force: :cascade do |t|
    t.string   "ref_no"
    t.string   "description"
    t.string   "address"
    t.decimal  "lat"
    t.decimal  "lng"
    t.datetime "report_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "report_type_id", null: false
    t.integer  "status",         null: false
    t.datetime "complete_date"
    t.string   "answer"
    t.string   "plate_number"
  end

  add_index "reports", ["ref_no"], name: "index_reports_on_ref_no", unique: true, using: :btree
  add_index "reports", ["report_type_id"], name: "index_reports_on_report_type_id", using: :btree

end
