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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 10) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email"
  add_index "accounts", ["name"], :name => "index_accounts_on_name"
  add_index "accounts", ["role"], :name => "index_accounts_on_role"

  create_table "applications", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "email"
    t.string   "phone"
    t.string   "status"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "comment"
    t.integer  "room_id"
    t.integer  "team_type"
  end

  add_index "applications", ["account_id"], :name => "index_applications_on_account_id"
  add_index "applications", ["end_at"], :name => "index_applications_on_end_at"
  add_index "applications", ["room_id"], :name => "index_applications_on_room_id"
  add_index "applications", ["start_at"], :name => "index_applications_on_start_at"
  add_index "applications", ["status"], :name => "index_applications_on_status"

  create_table "messages", :force => true do |t|
    t.string   "content"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_read"
  end

  add_index "messages", ["account_id"], :name => "index_messages_on_account_id"
  add_index "messages", ["is_read"], :name => "index_messages_on_is_read"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
