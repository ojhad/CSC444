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

ActiveRecord::Schema.define(version: 20171117200327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charges", force: :cascade do |t|
    t.string "stripe_charge_id"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_charges_on_user_id"
  end

  create_table "endorsement_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "invitee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["invitee_id"], name: "index_endorsement_requests_on_invitee_id"
    t.index ["user_id"], name: "index_endorsement_requests_on_user_id"
  end

  create_table "endorsements", force: :cascade do |t|
    t.text "body"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_endorsements_on_user_id"
  end

  create_table "finances", force: :cascade do |t|
    t.string "year"
    t.string "month"
    t.float "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false, null: false
    t.bigint "user_id"
    t.bigint "reference_user_id"
    t.bigint "reference_service_id"
    t.index ["reference_service_id"], name: "index_notifications_on_reference_service_id"
    t.index ["reference_user_id"], name: "index_notifications_on_reference_user_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payout_informations", force: :cascade do |t|
    t.string "paypal"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "method", default: "check"
    t.index ["user_id"], name: "index_payout_informations_on_user_id"
  end

  create_table "payouts", force: :cascade do |t|
    t.float "amount"
    t.string "batch_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "method"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.float "rating", default: 5.0
    t.integer "author_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "service_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_users_on_service_id"
    t.index ["user_id"], name: "index_service_users_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.float "charge_per_hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "frequency"
    t.integer "min_age"
    t.integer "max_age"
    t.string "other_title"
    t.string "description"
    t.index ["user_id"], name: "index_services_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "skill_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teen_times", force: :cascade do |t|
    t.integer "user_id"
    t.string "day"
    t.time "start_time"
    t.time "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.float "total_amount"
    t.float "number_of_hours"
    t.float "charge_per_hour"
    t.text "service_title"
    t.bigint "teen_id"
    t.bigint "client_id"
    t.bigint "service_id"
    t.integer "status", default: 0, null: false
    t.index ["client_id"], name: "index_transactions_on_client_id"
    t.index ["service_id"], name: "index_transactions_on_service_id"
    t.index ["teen_id"], name: "index_transactions_on_teen_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "skill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "province"
    t.string "postal_code"
    t.string "country"
    t.string "home_number"
    t.string "mobile_number"
    t.integer "age"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "profile_picture_file_name"
    t.string "profile_picture_content_type"
    t.integer "profile_picture_file_size"
    t.datetime "profile_picture_updated_at"
    t.integer "group"
    t.string "first_name"
    t.string "last_name"
    t.float "average_rating"
    t.float "latitude"
    t.float "longitude"
    t.string "profile_pic_file_name"
    t.string "profile_pic_content_type"
    t.integer "profile_pic_file_size"
    t.datetime "profile_pic_updated_at"
    t.string "stripe_id"
    t.float "balance", default: 0.0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "charges", "users"
  add_foreign_key "endorsement_requests", "users"
  add_foreign_key "endorsement_requests", "users", column: "invitee_id"
  add_foreign_key "endorsements", "users"
  add_foreign_key "notifications", "services", column: "reference_service_id"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "reference_user_id"
  add_foreign_key "payout_informations", "users"
  add_foreign_key "reviews", "users"
  add_foreign_key "service_users", "services"
  add_foreign_key "service_users", "users"
  add_foreign_key "services", "users"
  add_foreign_key "transactions", "services"
  add_foreign_key "transactions", "users", column: "client_id"
  add_foreign_key "transactions", "users", column: "teen_id"
end
