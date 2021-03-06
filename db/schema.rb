# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_10_104113) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "development_id"
    t.string "body"
    t.integer "rating"
    t.datetime "created_at"
  end

  create_table "developments", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "developer_id"
  end

  create_table "follower_developers", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "developer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "developer"
    t.string "website"
    t.string "company"
  end

end
