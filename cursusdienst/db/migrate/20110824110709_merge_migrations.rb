class MergeMigrations < ActiveRecord::Migration
	def change
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

		create_table "materials", :force => true do |t|
			t.string   "name"
			t.integer  "subject_id"
			t.datetime "created_at"
			t.datetime "updated_at"
			t.integer  "nr"
			t.integer  "parent_id"
			t.string   "path_name"
		end

		create_table "materials_options", :id => false, :force => true do |t|
			t.integer  "material_id"
			t.integer  "option_id"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "messages", :force => true do |t|
			t.integer  "guild_id"
			t.string   "content"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "options", :force => true do |t|
			t.datetime "created_at"
			t.datetime "updated_at"
			t.string   "name"
		end
		create_table "orders", :force => true do |t|
			t.integer  "user_id"
			t.integer  "guild_id"
			t.string   "order_key"
			t.string   "status"
			t.datetime "created_at"
			t.datetime "updated_at"
		end
		
		create_table "permission_groups", :force => true do |t|
			t.string   "name"
			t.integer  "level"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "permission_groups_users", :id => false, :force => true do |t|
			t.integer  "permission_group_id"
			t.integer  "user_id"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "sales", :force => true do |t|
			t.integer  "user_id"
			t.integer  "material_id"
			t.integer  "status"
			t.integer  "reference_key"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "subjects", :force => true do |t|
			t.string   "name"
			t.datetime "created_at"
			t.datetime "updated_at"
		end

		create_table "supplies", :force => true do |t|
			t.integer  "guild_id"
			t.integer  "material_id"
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
end
