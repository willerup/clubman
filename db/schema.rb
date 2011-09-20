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

ActiveRecord::Schema.define(:version => 20110920180324) do

  create_table "account_events", :force => true do |t|
    t.integer  "debit_id"
    t.integer  "credit_id"
    t.datetime "date"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_id"
    t.integer  "student_id"
    t.string   "credit_note"
    t.string   "debit_note"
  end

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_type"
    t.integer  "family_id"
    t.integer  "club_id"
  end

  create_table "clubs", :force => true do |t|
    t.text     "name"
    t.text     "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "term_id"
    t.integer  "income_id"
    t.integer  "expenses_id"
    t.integer  "cash_id"
    t.integer  "liabilities_id"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "closed"
    t.integer  "term_id"
  end

  create_table "families", :force => true do |t|
    t.string   "name"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id"
    t.string   "email"
    t.string   "phone"
    t.string   "notes"
  end

  create_table "games", :force => true do |t|
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "result"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "style"
    t.integer  "term_id"
  end

  create_table "groups_students", :id => false, :force => true do |t|
    t.integer  "student_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer  "student_id"
    t.integer  "rating"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "delta"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
  end

  create_table "students", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "family_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade"
    t.boolean  "active"
    t.integer  "rating"
    t.integer  "club_id"
    t.boolean  "current"
  end

  create_table "students_terms", :id => false, :force => true do |t|
    t.integer "student_id"
    t.integer "term_id"
  end

  create_table "terms", :force => true do |t|
    t.string   "name"
    t.integer  "club_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "start_event_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "name"
    t.integer  "family_id"
    t.string   "phone"
    t.string   "crypted_password",                 :null => false
    t.string   "password_salt",                    :null => false
    t.string   "persistence_token",                :null => false
    t.integer  "login_count",       :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "coach"
    t.boolean  "admin"
    t.integer  "group_id"
    t.string   "perishable_token"
    t.integer  "club_id"
    t.boolean  "god"
  end

end
