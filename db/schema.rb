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

ActiveRecord::Schema.define(version: 20160422013005) do

  create_table "claims", force: :cascade do |t|
    t.integer  "insured_id",              null: false
    t.integer  "provider_id",             null: false
    t.integer  "status",      default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "claims", ["insured_id"], name: "index_claims_on_insured_id"
  add_index "claims", ["provider_id"], name: "index_claims_on_provider_id"

  create_table "services", force: :cascade do |t|
    t.integer  "claim_id",   null: false
    t.string   "code"
    t.float    "cost"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "services", ["claim_id"], name: "index_services_on_claim_id"

  create_table "submissions", force: :cascade do |t|
    t.integer  "insured_id",  null: false
    t.integer  "provider_id", null: false
    t.integer  "claim_id"
    t.text     "services"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "submissions", ["insured_id"], name: "index_submissions_on_insured_id"
  add_index "submissions", ["provider_id"], name: "index_submissions_on_provider_id"

  create_table "users", force: :cascade do |t|
    t.string   "api_key"
    t.boolean  "internal",   default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "users", ["api_key"], name: "index_users_on_api_key", unique: true

end
