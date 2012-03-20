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

ActiveRecord::Schema.define(:version => 20120320144649) do

  create_table "competitions", :force => true do |t|
    t.string   "name"
    t.integer  "golf_field_id"
    t.datetime "competition_date"
    t.integer  "firsthalf_cource_id"
    t.integer  "secondhalf_cource_id"
    t.integer  "host_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_cources", :force => true do |t|
    t.string   "name"
    t.integer  "golf_field_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_fields", :force => true do |t|
    t.string   "name"
    t.integer  "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_fields_greens", :force => true do |t|
    t.integer  "golf_field_id"
    t.integer  "green_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "golf_holes", :force => true do |t|
    t.integer  "golf_cource_id"
    t.integer  "hole_no"
    t.integer  "par"
    t.integer  "yard"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "greens", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", :force => true do |t|
    t.integer  "party_no"
    t.integer  "competition_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "party_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shot_results", :force => true do |t|
    t.integer  "player_id"
    t.integer  "hole_id"
    t.integer  "shot_num"
    t.integer  "pat_num"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "openid"
    t.string   "email"
    t.string   "password"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
