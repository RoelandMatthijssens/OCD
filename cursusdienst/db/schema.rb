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

ActiveRecord::Schema.define(:version => 20110727114016) do

  create_table "disciplines", :force => true do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "faculties", ["institute_id"], :name => "index_faculties_on_institute_id"

  create_table "guilds", :force => true do |t|
    t.string  "name"
    t.string  "initials"
    t.integer "discipline_id"
  end

  create_table "guilds_users", :id => false, :force => true do |t|
    t.integer "guild_id"
    t.integer "user_id"
  end

  create_table "institutes", :force => true do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_options", :force => true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.string   "name"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "nr"
  end

  create_table "permission_groups", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.integer  "material_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "guild_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachings", :force => true do |t|
    t.integer  "discipline_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

end
