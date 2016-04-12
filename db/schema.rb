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

ActiveRecord::Schema.define(version: 20160412214757) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "use_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "pin_id"
  end

  add_index "microposts", ["pin_id", "created_at"], name: "index_microposts_on_pin_id_and_created_at"
  add_index "microposts", ["pin_id"], name: "index_microposts_on_pin_id"
  add_index "microposts", ["use_id", "created_at"], name: "index_microposts_on_use_id_and_created_at"
  add_index "microposts", ["use_id"], name: "index_microposts_on_use_id"

  create_table "picture_frames", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "image_meta"
    t.string   "aspect"
    t.integer  "top"
    t.integer  "left"
  end

  create_table "pin_colors", force: :cascade do |t|
    t.integer  "pin_id"
    t.string   "original_color"
    t.string   "reference_color"
    t.float    "frequency"
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pin_colors", ["distance"], name: "index_pin_colors_on_distance"
  add_index "pin_colors", ["frequency"], name: "index_pin_colors_on_frequency"
  add_index "pin_colors", ["original_color"], name: "index_pin_colors_on_original_color"
  add_index "pin_colors", ["pin_id"], name: "index_pin_colors_on_pin_id"
  add_index "pin_colors", ["reference_color"], name: "index_pin_colors_on_reference_color"

  create_table "pins", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "use_id"
    t.integer  "aspect"
    t.text     "image_meta"
    t.decimal  "price"
  end

  add_index "pins", ["use_id"], name: "index_pins_on_use_id"
  add_index "pins", ["user_id"], name: "index_pins_on_user_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",               precision: 12, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "pin_id"
    t.integer  "use_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "uses", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "avatar_url"
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
