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

ActiveRecord::Schema.define(:version => 20111107172332) do

  create_table "action_logs", :force => true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted"
  end

  create_table "attachments", :force => true do |t|
    t.integer  "material_id"
    t.string   "item"
    t.string   "content_type"
    t.integer  "file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",      :default => false
  end

  create_table "book_costs", :force => true do |t|
    t.float    "amount"
    t.integer  "supply_id"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disciplines", :force => true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "disciplines_guilds", :id => false, :force => true do |t|
    t.integer "guild_id"
    t.integer "discipline_id"
  end

  create_table "disciplines_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "discipline_id"
  end

  create_table "faculties", :force => true do |t|
    t.string   "name"
    t.integer  "institute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "initials"
    t.boolean  "deleted",      :default => false
  end

  add_index "faculties", ["institute_id"], :name => "index_faculties_on_institute_id"

  create_table "foobars", :force => true do |t|
    t.boolean  "deleted"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "guilds", :force => true do |t|
    t.string  "name"
    t.string  "initials"
    t.integer "discipline_id"
    t.boolean "deleted",       :default => false
  end

  create_table "guilds_users", :id => false, :force => true do |t|
    t.integer "guild_id"
    t.integer "user_id"
  end

  create_table "info_strings", :force => true do |t|
    t.string   "key"
    t.text     "content"
    t.integer  "guild_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "institutes", :force => true do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "material_orders", :force => true do |t|
    t.integer  "order_id"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "guild_id"
    t.integer  "amount"
    t.boolean  "deleted",      :default => false
    t.float    "price"
    t.string   "status"
    t.integer  "print_job_id"
    t.float    "buy_price"
  end

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nr"
    t.integer  "parent_id"
    t.string   "path_name"
    t.string   "typee"
    t.string   "info"
    t.integer  "page_count", :default => -1
    t.boolean  "printable"
    t.boolean  "deleted",    :default => false
    t.integer  "owner_id"
  end

  create_table "materials_options", :id => false, :force => true do |t|
    t.integer  "material_id"
    t.integer  "option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "guild_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "options", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "typee"
    t.boolean  "deleted",    :default => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "order_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "institute_id"
    t.string   "payment_type"
    t.string   "label"
    t.boolean  "deleted",      :default => false
  end

  create_table "permission_groups", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "permission_groups_users", :id => false, :force => true do |t|
    t.integer  "permission_group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "price_sets", :force => true do |t|
    t.integer  "printer_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "prices", :force => true do |t|
    t.integer  "price_set_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "option_id"
    t.string   "typee"
    t.boolean  "deleted",      :default => false
  end

  create_table "print_job_items", :force => true do |t|
    t.integer  "print_job_id"
    t.integer  "material_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",      :default => false
  end

  create_table "print_jobs", :force => true do |t|
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
    t.float    "price"
  end

  create_table "printers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",    :default => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "score"
    t.string   "message"
    t.integer  "user_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",       :default => false
  end

  create_table "sales", :force => true do |t|
    t.integer  "user_id"
    t.integer  "material_id"
    t.integer  "status"
    t.integer  "reference_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",       :default => false
  end

  create_table "shopping_cart_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "material_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "guild_id"
    t.boolean  "deleted",     :default => false
  end

  create_table "stocks", :force => true do |t|
    t.integer  "material_id"
    t.integer  "guild_id"
    t.integer  "amount"
    t.integer  "threshold"
    t.integer  "step"
    t.string   "typee"
    t.integer  "floating"
    t.integer  "floating_period"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",         :default => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.integer  "year"
    t.string   "year_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "prof"
    t.boolean  "deleted",    :default => false
  end

  create_table "supplies", :force => true do |t|
    t.integer  "guild_id"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price_set_id"
    t.float    "price"
    t.boolean  "deleted",      :default => false
  end

  create_table "teachings", :force => true do |t|
    t.integer  "discipline_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",       :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.integer  "rolno"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "permission_group_id", :default => 0
    t.string   "name"
    t.string   "last_name"
    t.string   "password"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "deleted",             :default => false
  end

end
