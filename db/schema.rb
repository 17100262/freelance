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

ActiveRecord::Schema.define(version: 20180614102350) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.bigint "job_id"
    t.index ["job_id"], name: "index_attachments_on_job_id"
  end

  create_table "blocked_users", force: :cascade do |t|
    t.bigint "job_id"
    t.bigint "user_id"
    t.index ["job_id"], name: "index_blocked_users_on_job_id"
    t.index ["user_id"], name: "index_blocked_users_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_engine_chat_subscribers", force: :cascade do |t|
    t.string "subscriber_type"
    t.bigint "subscriber_id"
    t.integer "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_engine_chats", force: :cascade do |t|
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_engine_messages", force: :cascade do |t|
    t.string "sender_type"
    t.bigint "sender_id"
    t.text "content"
    t.integer "chat_id"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.index ["sender_type", "sender_id"], name: "index_chat_engine_messages_on_sender_type_and_sender_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "status", default: "PENDING"
    t.string "title"
    t.text "description"
    t.text "deliverables"
    t.integer "duration"
    t.string "language"
    t.float "amount"
    t.boolean "online"
    t.text "address"
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
    t.bigint "user_id"
    t.bigint "category_id"
    t.bigint "subcategory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "express_token"
    t.string "express_payer_id"
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["slug"], name: "index_jobs_on_slug"
    t.index ["subcategory_id"], name: "index_jobs_on_subcategory_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "event"
    t.bigint "user_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "notifs", force: :cascade do |t|
    t.string "event"
    t.bigint "user_id"
    t.boolean "read"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifs_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "status", default: "PENDING"
    t.bigint "user_id"
    t.bigint "job_id"
    t.datetime "ending_time"
    t.datetime "reviewed_at"
    t.float "amount"
    t.string "review"
    t.integer "rating"
    t.text "revision_description"
    t.text "rejection_description"
    t.text "pause_reason"
    t.datetime "paused_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["job_id"], name: "index_reservations_on_job_id"
    t.index ["slug"], name: "index_reservations_on_slug"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "statements", force: :cascade do |t|
    t.bigint "user_id"
    t.string "email"
    t.float "amount"
    t.string "status"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_statements_on_slug", unique: true
    t.index ["user_id"], name: "index_statements_on_user_id"
  end

  create_table "subcategories", force: :cascade do |t|
    t.string "name"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_subcategories_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "username"
    t.string "phone_number"
    t.string "identifier"
    t.string "company_name"
    t.string "linkedin_link"
    t.string "githhub_link"
    t.string "website_link"
    t.string "portfolio"
    t.string "other_link1"
    t.string "other_link2"
    t.string "other_link3"
    t.text "experience"
    t.boolean "admin", default: false
    t.float "balance", default: 0.0
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.boolean "online", default: false
    t.string "paypal_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.integer "value"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "blocked_users", "jobs"
  add_foreign_key "blocked_users", "users"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "subcategories"
  add_foreign_key "jobs", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifs", "users"
  add_foreign_key "reservations", "jobs"
  add_foreign_key "reservations", "users"
  add_foreign_key "statements", "users"
  add_foreign_key "subcategories", "categories"
end
