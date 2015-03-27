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

ActiveRecord::Schema.define(version: 20150327182637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_types", force: :cascade do |t|
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "action_types", ["organization_id"], name: "index_action_types_on_organization_id", using: :btree

  create_table "actions", force: :cascade do |t|
    t.integer  "action_type_id"
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "actions", ["action_type_id"], name: "index_actions_on_action_type_id", using: :btree
  add_index "actions", ["report_id"], name: "index_actions_on_report_id", using: :btree
  add_index "actions", ["user_id"], name: "index_actions_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.text     "description"
    t.text     "phone_number"
    t.integer  "venue_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contacts", ["venue_id"], name: "index_contacts_on_venue_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.text     "url",        null: false
    t.integer  "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "pictures", ["report_id"], name: "index_pictures_on_report_id", using: :btree

  create_table "report_field_types", force: :cascade do |t|
    t.text     "description"
    t.integer  "report_type_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "report_field_types", ["report_type_id"], name: "index_report_field_types_on_report_type_id", using: :btree

  create_table "report_fields", force: :cascade do |t|
    t.integer  "report_id"
    t.integer  "report_field_type_id"
    t.text     "value"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "report_fields", ["report_field_type_id"], name: "index_report_fields_on_report_field_type_id", using: :btree
  add_index "report_fields", ["report_id"], name: "index_report_fields_on_report_id", using: :btree

  create_table "report_states", force: :cascade do |t|
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "report_states", ["organization_id"], name: "index_report_states_on_organization_id", using: :btree

  create_table "report_types", force: :cascade do |t|
    t.text     "description"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "report_types", ["organization_id"], name: "index_report_types_on_organization_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "creator_id",       null: false
    t.integer  "assigned_user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "report_state_id"
    t.integer  "report_type_id"
    t.integer  "venue_id"
  end

  add_index "reports", ["assigned_user_id"], name: "index_reports_on_assigned_user_id", using: :btree
  add_index "reports", ["creator_id"], name: "index_reports_on_creator_id", using: :btree
  add_index "reports", ["report_state_id"], name: "index_reports_on_report_state_id", using: :btree
  add_index "reports", ["report_type_id"], name: "index_reports_on_report_type_id", using: :btree
  add_index "reports", ["venue_id"], name: "index_reports_on_venue_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["organization_id"], name: "index_users_on_organization_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "venues", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "venues", ["organization_id"], name: "index_venues_on_organization_id", using: :btree

  add_foreign_key "action_types", "organizations"
  add_foreign_key "actions", "action_types"
  add_foreign_key "actions", "reports"
  add_foreign_key "actions", "users"
  add_foreign_key "contacts", "venues"
  add_foreign_key "pictures", "reports"
  add_foreign_key "report_field_types", "report_types"
  add_foreign_key "report_fields", "report_field_types"
  add_foreign_key "report_fields", "reports"
  add_foreign_key "report_states", "organizations"
  add_foreign_key "report_types", "organizations"
  add_foreign_key "reports", "report_states"
  add_foreign_key "reports", "report_types"
  add_foreign_key "reports", "users", column: "assigned_user_id"
  add_foreign_key "reports", "users", column: "creator_id"
  add_foreign_key "reports", "venues"
  add_foreign_key "users", "organizations"
  add_foreign_key "venues", "organizations"
end
