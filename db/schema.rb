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

ActiveRecord::Schema.define(version: 20160324185959) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "channels", force: :cascade do |t|
    t.text     "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "image"
    t.integer  "workspace_id"
    t.datetime "deleted_at"
  end

  add_index "channels", ["deleted_at"], name: "index_channels_on_deleted_at", using: :btree
  add_index "channels", ["workspace_id"], name: "index_channels_on_workspace_id", using: :btree

  create_table "checklist_categories", force: :cascade do |t|
    t.text     "name",         null: false
    t.integer  "checklist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "checklist_categories", ["checklist_id", "name"], name: "index_checklist_categories_on_checklist_id_and_name", unique: true, using: :btree
  add_index "checklist_categories", ["checklist_id"], name: "index_checklist_categories_on_checklist_id", using: :btree

  create_table "checklist_items", force: :cascade do |t|
    t.integer  "checklist_category_id"
    t.text     "name",                  null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.text     "suggestion"
  end

  add_index "checklist_items", ["checklist_category_id", "name"], name: "index_checklist_items_on_checklist_category_id_and_name", unique: true, using: :btree
  add_index "checklist_items", ["checklist_category_id"], name: "index_checklist_items_on_checklist_category_id", using: :btree

  create_table "checklists", force: :cascade do |t|
    t.text     "name",         null: false
    t.integer  "workspace_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "image"
  end

  add_index "checklists", ["workspace_id", "name"], name: "index_checklists_on_workspace_id_and_name", unique: true, using: :btree
  add_index "checklists", ["workspace_id"], name: "index_checklists_on_workspace_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.integer  "workspace_id"
    t.text     "name",         null: false
    t.text     "rut",          null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
  end

  add_index "clients", ["deleted_at"], name: "index_clients_on_deleted_at", using: :btree
  add_index "clients", ["rut"], name: "index_clients_on_rut", unique: true, using: :btree

  create_table "communes", force: :cascade do |t|
    t.integer  "region_id",  null: false
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "communes", ["region_id", "name"], name: "index_communes_on_region_id_and_name", unique: true, using: :btree
  add_index "communes", ["region_id"], name: "index_communes_on_region_id", using: :btree

  create_table "constructions", force: :cascade do |t|
    t.integer  "client_id"
    t.text     "name",       null: false
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "unique_id",  null: false
    t.datetime "deleted_at"
  end

  add_index "constructions", ["client_id", "unique_id"], name: "index_constructions_on_client_id_and_unique_id", unique: true, using: :btree
  add_index "constructions", ["deleted_at"], name: "index_constructions_on_deleted_at", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "construction_id"
    t.text     "name"
    t.text     "email"
    t.text     "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "deleted_at"
  end

  add_index "contacts", ["deleted_at"], name: "index_contacts_on_deleted_at", using: :btree

  create_table "contest_phrases", force: :cascade do |t|
    t.integer  "organization_id"
    t.integer  "tier",            null: false
    t.text     "phrase",          null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "contest_phrases", ["organization_id"], name: "index_contest_phrases_on_organization_id", using: :btree

  create_table "contests", force: :cascade do |t|
    t.integer  "workspace_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.text     "prize_image"
    t.float    "tier_steps",        default: [0.33, 0.66], null: false, array: true
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "prize_description"
  end

  add_index "contests", ["workspace_id"], name: "index_contests_on_workspace_id", using: :btree

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "device_token"
    t.text     "registration_id"
    t.text     "uuid"
    t.text     "architecture"
    t.text     "address"
    t.text     "locale"
    t.text     "manufacturer"
    t.text     "model"
    t.text     "name"
    t.text     "os_name"
    t.integer  "processor_count"
    t.text     "version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "devices", ["device_token"], name: "index_devices_on_device_token", unique: true, using: :btree
  add_index "devices", ["registration_id"], name: "index_devices_on_registration_id", unique: true, using: :btree
  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree
  add_index "devices", ["uuid"], name: "index_devices_on_uuid", unique: true, using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "rating",     null: false
  end

  add_index "feedbacks", ["rating"], name: "index_feedbacks_on_rating", using: :btree
  add_index "feedbacks", ["user_id"], name: "index_feedbacks_on_user_id", using: :btree

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

  create_table "products", force: :cascade do |t|
    t.text     "name"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reasons", force: :cascade do |t|
    t.integer  "workspace_id"
    t.text     "name",         null: false
    t.text     "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
  end

  add_index "reasons", ["deleted_at"], name: "index_reasons_on_deleted_at", using: :btree
  add_index "reasons", ["workspace_id"], name: "index_reasons_on_workspace_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.text     "name",          null: false
    t.text     "roman_numeral", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "number"
  end

  add_index "regions", ["name"], name: "index_regions_on_name", unique: true, using: :btree
  add_index "regions", ["roman_numeral"], name: "index_regions_on_roman_numeral", unique: true, using: :btree

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
    t.integer  "index"
  end

  add_index "report_field_types", ["widget_id"], name: "index_report_field_types_on_widget_id", using: :btree
  add_index "report_field_types", ["workspace_id"], name: "index_report_field_types_on_workspace_id", using: :btree

  create_table "report_fields", force: :cascade do |t|
    t.integer  "report_id"
    t.integer  "report_field_type_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.json     "value",                                null: false
    t.boolean  "editable",             default: false, null: false
  end

  add_index "report_fields", ["report_field_type_id"], name: "index_report_fields_on_report_field_type_id", using: :btree
  add_index "report_fields", ["report_id"], name: "index_report_fields_on_report_id", using: :btree

  create_table "report_states", force: :cascade do |t|
    t.text     "name",                         null: false
    t.integer  "workspace_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.text     "short_name"
    t.boolean  "editable",     default: false, null: false
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
    t.integer  "creator_id",                     null: false
    t.integer  "assigned_user_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "report_state_id"
    t.integer  "workspace_id"
    t.text     "title",                          null: false
    t.text     "address"
    t.text     "city"
    t.text     "region"
    t.text     "commune"
    t.text     "country"
    t.float    "longitude",        default: 0.0
    t.float    "latitude",         default: 0.0
    t.text     "reference"
    t.text     "comment"
    t.text     "pdf"
    t.integer  "reason_id"
    t.integer  "channel_id"
    t.integer  "subchannel_id"
    t.text     "internal_id",                    null: false
    t.datetime "start_date"
    t.datetime "finish_date"
    t.float    "finish_latitude"
    t.float    "finish_longitude"
    t.datetime "visit_date"
    t.float    "start_latitude"
    t.float    "start_longitude"
    t.datetime "deleted_at"
  end

  add_index "reports", ["assigned_user_id"], name: "index_reports_on_assigned_user_id", using: :btree
  add_index "reports", ["channel_id"], name: "index_reports_on_channel_id", using: :btree
  add_index "reports", ["creator_id"], name: "index_reports_on_creator_id", using: :btree
  add_index "reports", ["deleted_at"], name: "index_reports_on_deleted_at", using: :btree
  add_index "reports", ["internal_id"], name: "index_reports_on_internal_id", unique: true, using: :btree
  add_index "reports", ["reason_id"], name: "index_reports_on_reason_id", using: :btree
  add_index "reports", ["report_state_id"], name: "index_reports_on_report_state_id", using: :btree
  add_index "reports", ["subchannel_id"], name: "index_reports_on_subchannel_id", using: :btree
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subchannels", ["channel_id"], name: "index_subchannels_on_channel_id", using: :btree

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

  create_table "widgets", force: :cascade do |t|
    t.text     "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workspace_invitations", force: :cascade do |t|
    t.integer  "workspace_id",                       null: false
    t.integer  "user_id"
    t.boolean  "accepted",           default: false, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.text     "confirmation_token",                 null: false
    t.text     "user_email",                         null: false
  end

  add_index "workspace_invitations", ["confirmation_token"], name: "index_workspace_invitations_on_confirmation_token", unique: true, using: :btree
  add_index "workspace_invitations", ["user_id"], name: "index_workspace_invitations_on_user_id", using: :btree
  add_index "workspace_invitations", ["workspace_id", "user_email"], name: "index_workspace_invitations_on_workspace_id_and_user_email", unique: true, using: :btree
  add_index "workspace_invitations", ["workspace_id"], name: "index_workspace_invitations_on_workspace_id", using: :btree

  create_table "workspaces", force: :cascade do |t|
    t.text     "name"
    t.integer  "organization_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_open",                 default: true, null: false
    t.text     "email"
    t.text     "welcome_message"
    t.text     "confirm_message"
    t.integer  "max_pictures",            default: 20,   null: false
    t.integer  "default_report_state_id"
  end

  add_index "workspaces", ["organization_id"], name: "index_workspaces_on_organization_id", using: :btree

  create_table "zone_assignments", force: :cascade do |t|
    t.integer  "channel_id"
    t.integer  "subchannel_id"
    t.integer  "region_id"
    t.integer  "commune_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "workspace_id",  null: false
  end

  add_index "zone_assignments", ["channel_id"], name: "index_zone_assignments_on_channel_id", using: :btree
  add_index "zone_assignments", ["commune_id"], name: "index_zone_assignments_on_commune_id", using: :btree
  add_index "zone_assignments", ["region_id"], name: "index_zone_assignments_on_region_id", using: :btree
  add_index "zone_assignments", ["subchannel_id"], name: "index_zone_assignments_on_subchannel_id", using: :btree
  add_index "zone_assignments", ["workspace_id"], name: "index_zone_assignments_on_workspace_id", using: :btree

  create_table "zone_managers", force: :cascade do |t|
    t.integer  "zone_assignment_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "zone_managers", ["user_id"], name: "index_zone_managers_on_user_id", using: :btree
  add_index "zone_managers", ["zone_assignment_id"], name: "index_zone_managers_on_zone_assignment_id", using: :btree

  add_foreign_key "channels", "workspaces"
  add_foreign_key "checklist_categories", "checklists"
  add_foreign_key "checklist_items", "checklist_categories"
  add_foreign_key "checklists", "workspaces"
  add_foreign_key "communes", "regions"
  add_foreign_key "contest_phrases", "organizations"
  add_foreign_key "contests", "workspaces"
  add_foreign_key "devices", "users"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "pictures", "reports"
  add_foreign_key "reasons", "workspaces"
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
  add_foreign_key "reports", "channels"
  add_foreign_key "reports", "reasons"
  add_foreign_key "reports", "report_states"
  add_foreign_key "reports", "subchannels"
  add_foreign_key "reports", "users", column: "assigned_user_id"
  add_foreign_key "reports", "users", column: "creator_id"
  add_foreign_key "reports", "workspaces"
  add_foreign_key "subchannels", "channels"
  add_foreign_key "workspace_invitations", "users"
  add_foreign_key "workspace_invitations", "workspaces"
  add_foreign_key "workspaces", "organizations"
  add_foreign_key "zone_assignments", "channels"
  add_foreign_key "zone_assignments", "communes"
  add_foreign_key "zone_assignments", "regions"
  add_foreign_key "zone_assignments", "subchannels"
  add_foreign_key "zone_assignments", "workspaces"
  add_foreign_key "zone_managers", "users"
  add_foreign_key "zone_managers", "zone_assignments"
end
