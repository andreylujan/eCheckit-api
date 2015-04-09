class CreateSchema < ActiveRecord::Migration
  def change
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
    end

    add_index "pictures", ["report_id"], name: "index_pictures_on_report_id", using: :btree

    create_table "report_field_types", force: :cascade do |t|
      t.text     "description"
      t.integer  "workspace_id"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    add_index "report_field_types", ["workspace_id"], name: "index_report_field_types_on_workspace_id", using: :btree

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
      t.integer  "workspace_id"
      t.datetime "created_at",   null: false
      t.datetime "updated_at",   null: false
    end

    add_index "report_states", ["workspace_id"], name: "index_report_states_on_workspace_id", using: :btree

    create_table "reports", force: :cascade do |t|
      t.integer  "creator_id",       null: false
      t.integer  "assigned_user_id"
      t.datetime "created_at",       null: false
      t.datetime "updated_at",       null: false
      t.integer  "report_state_id"
      t.integer  "workspace_id"
      t.integer  "venue_id"
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

    create_table "workspaces", force: :cascade do |t|
      t.text     "description"
      t.integer  "organization_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    add_index "workspaces", ["organization_id"], name: "index_workspaces_on_organization_id", using: :btree

    add_foreign_key "action_types", "organizations"
    add_foreign_key "actions", "action_types"
    add_foreign_key "actions", "reports"
    add_foreign_key "actions", "users"
    add_foreign_key "contacts", "venues"
    add_foreign_key "pictures", "reports"
    add_foreign_key "report_field_types", "workspaces"
    add_foreign_key "report_fields", "report_field_types"
    add_foreign_key "report_fields", "reports"
    add_foreign_key "report_states", "workspaces"
    add_foreign_key "reports", "report_states"
    add_foreign_key "reports", "users", column: "assigned_user_id"
    add_foreign_key "reports", "users", column: "creator_id"
    add_foreign_key "reports", "venues"
    add_foreign_key "reports", "workspaces"
    add_foreign_key "venues", "organizations"
    add_foreign_key "workspaces", "organizations"
  end
end