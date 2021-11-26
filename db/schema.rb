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

ActiveRecord::Schema.define(version: 2021_11_26_102246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "applications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "job_id", null: false
    t.text "cover_letter"
    t.string "education"
    t.string "telephone"
    t.date "date_of_birth"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["job_id"], name: "index_applications_on_job_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "category_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_name"], name: "index_categories_on_category_name", unique: true
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "category_id"
    t.bigint "user_id", null: false
    t.date "valid_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_jobs_on_category_id"
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

# Could not dump table "users" because of following StandardError
#   Unknown type 'user_type' for column 'type_of'

  add_foreign_key "applications", "jobs"
  add_foreign_key "applications", "users"
  add_foreign_key "jobs", "categories"
  add_foreign_key "jobs", "users"
end
