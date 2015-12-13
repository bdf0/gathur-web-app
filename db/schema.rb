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

ActiveRecord::Schema.define(version: 20151213015138) do

  create_table "events", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "public"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "description"
    t.string   "creator_name"
  end

  add_index "events", ["user_id", "start_time"], name: "index_events_on_user_id_and_start_time"
  add_index "events", ["user_id"], name: "index_events_on_user_id"

  create_table "invitations", force: :cascade do |t|
    t.boolean  "accepted"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "display_name"
  end

  add_index "invitations", ["event_id"], name: "index_invitations_on_event_id"
  add_index "invitations", ["user_id", "event_id"], name: "index_invitations_on_user_id_and_event_id", unique: true
  add_index "invitations", ["user_id"], name: "index_invitations_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.string   "text"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "display_name"
  end

  add_index "messages", ["created_at"], name: "index_messages_on_created_at"
  add_index "messages", ["event_id"], name: "index_messages_on_event_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "auth_token"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true

end
