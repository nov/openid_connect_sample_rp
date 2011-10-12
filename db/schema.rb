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

ActiveRecord::Schema.define(:version => 20110909022417) do

  create_table "accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "open_ids", :force => true do |t|
    t.integer  "account_id"
    t.integer  "provider_id"
    t.string   "identifier"
    t.string   "access_token"
    t.string   "id_token",     :limit => 1024
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", :force => true do |t|
    t.integer  "account_id"
    t.string   "name"
    t.string   "identifier"
    t.string   "secret"
    t.string   "scope"
    t.string   "host"
    t.string   "scheme"
    t.string   "authorization_endpoint"
    t.string   "token_endpoint"
    t.string   "check_id_endpoint"
    t.string   "user_info_endpoint"
    t.boolean  "dynamic",                :default => false
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
