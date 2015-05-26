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

ActiveRecord::Schema.define(version: 20150526143449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.text     "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "channels", ["organization_id"], name: "index_channels_on_organization_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.text     "description"
    t.text     "phone_number"
    t.integer  "venue_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "contacts", ["venue_id"], name: "index_contacts_on_venue_id", using: :btree

  create_table "domains", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "domain",                                      null: false
    t.text     "default_email",                               null: false
    t.boolean  "allow_automatic_registration", default: true, null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "domains", ["domain"], name: "index_domains_on_domain", unique: true, using: :btree
  add_index "domains", ["organization_id", "default_email"], name: "index_domains_on_organization_id_and_default_email", unique: true, using: :btree
  add_index "domains", ["organization_id"], name: "index_domains_on_organization_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating",     null: false
  end

  add_index "feedbacks", ["rating"], name: "index_feedbacks_on_rating", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

  create_table "google_communes", force: :cascade do |t|
    t.text     "commune"
    t.text     "google_commune"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "google_regions", force: :cascade do |t|
    t.text     "region"
    t.text     "google_region"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer  "resource_owner_id", null: false
    t.integer  "application_id",    null: false
    t.string   "token",             null: false
    t.integer  "expires_in",        null: false
    t.text     "redirect_uri",      null: false
    t.datetime "created_at",        null: false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",             null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        null: false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "uid",                       null: false
    t.string   "secret",                    null: false
    t.text     "redirect_uri",              null: false
    t.string   "scopes",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

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
    t.text     "comment"
  end

  add_index "pictures", ["report_id"], name: "index_pictures_on_report_id", using: :btree

  create_table "report_action_types", force: :cascade do |t|
    t.text     "name"
    t.integer  "organization_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "formatted_name"
  end

  add_index "report_action_types", ["organization_id"], name: "index_report_action_types_on_organization_id", using: :btree

  create_table "report_actions", force: :cascade do |t|
    t.integer  "report_action_type_id"
    t.integer  "user_id"
    t.integer  "report_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.json     "data",                  default: {}, null: false
    t.integer  "report_state_id"
  end

  add_index "report_actions", ["report_action_type_id"], name: "index_report_actions_on_report_action_type_id", using: :btree
  add_index "report_actions", ["report_id"], name: "index_report_actions_on_report_id", using: :btree
  add_index "report_actions", ["report_state_id"], name: "index_report_actions_on_report_state_id", using: :btree
  add_index "report_actions", ["user_id"], name: "index_report_actions_on_user_id", using: :btree

  create_table "report_field_types", force: :cascade do |t|
    t.text     "name"
    t.integer  "workspace_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "widget_id"
    t.json     "translations"
    t.json     "data"
  end

  add_index "report_field_types", ["widget_id"], name: "index_report_field_types_on_widget_id", using: :btree
  add_index "report_field_types", ["workspace_id"], name: "index_report_field_types_on_workspace_id", using: :btree

  create_table "report_fields", force: :cascade do |t|
    t.integer  "report_id"
    t.integer  "report_field_type_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.json     "value",                null: false
  end

  add_index "report_fields", ["report_field_type_id"], name: "index_report_fields_on_report_field_type_id", using: :btree
  add_index "report_fields", ["report_id"], name: "index_report_fields_on_report_id", using: :btree

  create_table "report_states", force: :cascade do |t|
    t.text     "name",         null: false
    t.integer  "workspace_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "report_states", ["workspace_id", "name"], name: "index_report_states_on_workspace_id_and_name", unique: true, using: :btree
  add_index "report_states", ["workspace_id"], name: "index_report_states_on_workspace_id", using: :btree

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
    t.integer  "workspace_id"
    t.integer  "venue_id"
    t.text     "title",            null: false
    t.text     "address"
    t.text     "city"
    t.text     "region"
    t.text     "commune"
    t.text     "country"
    t.float    "longitude",        null: false
    t.float    "latitude",         null: false
    t.text     "reference"
    t.text     "comment"
  end

  add_index "reports", ["assigned_user_id"], name: "index_reports_on_assigned_user_id", using: :btree
  add_index "reports", ["creator_id"], name: "index_reports_on_creator_id", using: :btree
  add_index "reports", ["report_state_id"], name: "index_reports_on_report_state_id", using: :btree
  add_index "reports", ["venue_id"], name: "index_reports_on_venue_id", using: :btree
  add_index "reports", ["workspace_id"], name: "index_reports_on_workspace_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "subchannels", force: :cascade do |t|
    t.integer  "channel_id"
    t.text     "name"
    t.integer  "direct_manager_id"
    t.integer  "indirect_manager_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "subchannels", ["channel_id"], name: "index_subchannels_on_channel_id", using: :btree
  add_index "subchannels", ["direct_manager_id"], name: "index_subchannels_on_direct_manager_id", using: :btree
  add_index "subchannels", ["indirect_manager_id"], name: "index_subchannels_on_indirect_manager_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "first_name",                             null: false
    t.text     "last_name"
    t.text     "picture"
    t.boolean  "is_demo",                default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "venues", force: :cascade do |t|
    t.integer  "organization_id"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "venues", ["organization_id"], name: "index_venues_on_organization_id", using: :btree

  create_table "widgets", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workspace_invitations", force: :cascade do |t|
    t.integer  "workspace_id",                       null: false
    t.integer  "user_id",                            null: false
    t.boolean  "accepted",           default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "confirmation_token",                 null: false
  end

  add_index "workspace_invitations", ["confirmation_token"], name: "index_workspace_invitations_on_confirmation_token", unique: true, using: :btree
  add_index "workspace_invitations", ["user_id"], name: "index_workspace_invitations_on_user_id", using: :btree
  add_index "workspace_invitations", ["workspace_id"], name: "index_workspace_invitations_on_workspace_id", using: :btree

  create_table "workspaces", force: :cascade do |t|
    t.text     "name"
    t.integer  "organization_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "is_open",         default: true, null: false
  end

  add_index "workspaces", ["organization_id"], name: "index_workspaces_on_organization_id", using: :btree

  add_foreign_key "channels", "organizations"
  add_foreign_key "contacts", "venues"
  add_foreign_key "domains", "organizations"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "pictures", "reports"
  add_foreign_key "report_action_types", "organizations"
  add_foreign_key "report_actions", "report_action_types"
  add_foreign_key "report_actions", "report_states"
  add_foreign_key "report_actions", "reports"
  add_foreign_key "report_actions", "users"
  add_foreign_key "report_field_types", "widgets"
  add_foreign_key "report_field_types", "workspaces"
  add_foreign_key "report_fields", "report_field_types"
  add_foreign_key "report_fields", "reports"
  add_foreign_key "report_states", "workspaces"
  add_foreign_key "reports", "report_states"
  add_foreign_key "reports", "users", column: "assigned_user_id"
  add_foreign_key "reports", "users", column: "creator_id"
  add_foreign_key "reports", "venues"
  add_foreign_key "reports", "workspaces"
  add_foreign_key "subchannels", "channels"
  add_foreign_key "venues", "organizations"
  add_foreign_key "workspace_invitations", "users"
  add_foreign_key "workspace_invitations", "workspaces"
  add_foreign_key "workspaces", "organizations"
end
