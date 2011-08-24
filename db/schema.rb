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

ActiveRecord::Schema.define(:version => 20110824060418) do

  create_table "dolls", :force => true do |t|
    t.integer  "user_id"
    t.integer  "doll_id"
    t.integer  "position"
    t.integer  "hp",         :default => 7
    t.integer  "maxhp",      :default => 7
    t.integer  "lv",         :default => 1
    t.integer  "exp",        :default => 0
    t.integer  "str",        :default => 1
    t.string   "job",        :default => "fig"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dungeons", :force => true do |t|
    t.integer  "town_id"
    t.integer  "lv",         :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "doll_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "doll_id"
    t.integer  "event_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "monsters", :force => true do |t|
    t.integer  "event_id"
    t.string   "name"
    t.integer  "hp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "towns", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "town_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
