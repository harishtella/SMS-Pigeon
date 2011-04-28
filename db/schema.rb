# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100519074532) do

  create_table "apartment_callbacks", :force => true do |t|
    t.datetime "apt_time"
    t.integer  "apartment_id"
    t.boolean  "completed",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "message"
  end

  create_table "apartment_pics", :force => true do |t|
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "apartment_id"
  end

  create_table "apartment_queries", :force => true do |t|
    t.integer  "apartment_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "apartment_statuses", :force => true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "apartment_id"
  end

  create_table "apartments", :force => true do |t|
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "pcb_disabled", :default => false
  end

  create_table "callbacks", :force => true do |t|
    t.string   "name"
    t.datetime "apt_time"
    t.integer  "apartment_id"
    t.boolean  "completed",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.string   "value"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "owner_type"
  end

  create_table "list_messages", :force => true do |t|
    t.string   "value"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "description"
  end

  create_table "lists_users", :id => false, :force => true do |t|
    t.integer "list_id"
    t.integer "user_id"
  end

  create_table "poll_choices", :force => true do |t|
    t.string   "keyword"
    t.string   "value"
    t.integer  "poll_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_questions", :force => true do |t|
    t.string   "value"
    t.integer  "poll_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "graph_filename"
  end

  create_table "poll_votes", :force => true do |t|
    t.integer  "poll_choice_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms", :force => true do |t|
    t.string   "text"
    t.boolean  "incoming"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sms_users", :id => false, :force => true do |t|
    t.integer "sms_id"
    t.integer "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "number"
    t.integer  "last_apt_queried_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "apartment_id"
    t.string   "room"
  end

end
