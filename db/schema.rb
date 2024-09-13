# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_13_014016) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "endpoint_statuses", force: :cascade do |t|
    t.bigint "endpoint_id", null: false
    t.datetime "request_sent_date"
    t.datetime "request_return_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_id"], name: "index_endpoint_statuses_on_endpoint_id"
  end

  create_table "endpoints", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_endpoints_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "endpoint_id", null: false
    t.datetime "started_at"
    t.datetime "finish_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endpoint_id"], name: "index_jobs_on_endpoint_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.boolean "user_active", default: true
    t.datetime "last_login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "endpoint_statuses", "endpoints"
  add_foreign_key "endpoints", "users"
  add_foreign_key "jobs", "endpoints"
  add_foreign_key "jobs", "users"
end
