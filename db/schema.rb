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

ActiveRecord::Schema.define(version: 20130917203244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimations", force: :cascade do |t|
    t.float    "user_time"
    t.string   "user_id"
    t.string   "card_id"
    t.string   "board_id"
    t.boolean  "is_manager"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "harvest_logs", force: :cascade do |t|
    t.string   "harvest_task_name"
    t.string   "harvest_task_id"
    t.string   "trello_card_name"
    t.string   "trello_card_id"
    t.float    "time_spent"
    t.string   "developer_email"
    t.date     "day"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "harvest_trello_id"
    t.integer  "harvest_entry_id"
  end

  add_index "harvest_logs", ["harvest_entry_id"], name: "index_harvest_logs_on_harvest_entry_id", using: :btree
  add_index "harvest_logs", ["harvest_trello_id"], name: "index_harvest_logs_on_harvest_trello_id", using: :btree

  create_table "harvest_trellos", force: :cascade do |t|
    t.string   "trello_board_name"
    t.string   "trello_board_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "harvest_project_id"
    t.string   "harvest_project_name"
  end

  add_index "harvest_trellos", ["harvest_project_id"], name: "index_harvest_trellos_on_harvest_project_id", using: :btree
  add_index "harvest_trellos", ["trello_board_id"], name: "index_harvest_trellos_on_trello_board_id", using: :btree

end
