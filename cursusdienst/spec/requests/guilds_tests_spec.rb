require 'spec_helper'

describe "GuildsTests" do
	before(:each) do
		@guild1 = Factory(:guild)
		@guild2 = Factory(:guild)
		@guild3 = Factory(:guild)
		@user1 = Factory(:user)
		@discipline = Factory(:discipline)
		@guilds = [@guild1, @guild2, @guild3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'guilds'" do
				it "should ask for login" do
					visit guilds_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1/edit'" do
				it "should ask for login" do
					visit edit_guild_path :id => @guild1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'guild/1'" do
				it "should ask for login" do
					visit guilds_path :id => @guild1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'guild/new'" do
				it "should ask for login" do
					visit new_guild_path
					page.should have_content "Please sign in to acces this page"
				end
			end
		end
	end
	describe "while logged in with no special permissions" do
		before(:each) do
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'guilds'" do
				it "should deny access" do
					visit guilds_path
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1/edit'" do
				it "should deny access" do
					visit edit_guild_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1'" do
				it "should deny access" do
					visit guilds_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/new'" do
				it "should deny access" do
					visit new_guild_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_guilds permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_guilds")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'guilds'" do
				it "should list all guilds" do
					visit guilds_path
					@guilds.each do |guild|
						page.should have_content(guild.name)
					end
				end
				it "should paginate the guilds" do
					10.times do
						@guilds << Factory(:guild)
					end
					visit guilds_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a guild when guild name is clicked" do
					visit guilds_path
					page.should have_link(@guild1.name)
					click_link(@guild1.name)
					page.should have_content(@guild1.name)
					page.should have_link("Edit")
				end
			end
			describe "'guild/1/edit'" do
				it "should deny access" do
					visit edit_guild_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1'" do
				it "should show the correct guild" do
					visit guilds_path :id => @guild1.id
					page.should have_content @guild1.name
					@guild1.users.each do |user|
						page.should have_content user.name
					end
				end
			end
			describe "'guild/new'" do
				it "should deny access" do
					visit new_guild_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_guilds permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_guilds")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'guilds'" do
				it "should deny access" do
					visit guilds_path
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1/edit'" do
				it "show the correct edit page" do
					visit edit_guild_path :id => @guild1.id
					page.should have_field "guild_name"
				end
			end
			describe "'guild/1'" do
				it "should deny access" do
					visit guilds_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/new'" do
				it "should deny access" do
					visit new_guild_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'guild/1/update'" do
				before(:each) do
					visit edit_guild_path :id => @guild1.id
				end
				fields = ["guild_name"]
				fields.each do |field|
					it "should update the guild" do
						fill_in field, :with => 'something'
						click_button "Update Guild"
						#can't check the page, since i have no read access
						#check if the guild has actually changed instead
						@guild1.reload
						@guild1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_guilds permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_guilds")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'guilds'" do
				it "should deny access" do
					visit guilds_path
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1/edit'" do
				it "should deny access" do
					visit edit_guild_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/1'" do
				it "should deny access" do
					visit guilds_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/new'" do
				it "should show the correct form" do
					visit new_guild_path
					page.should have_field "guild_name"
					page.should have_field "guild_initials"
				end
			end
		end
		describe "POST" do
			describe "'guild/1/update'" do
				it "should deny access" do
					visit edit_guild_path :id => @guild1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'guild/new'" do
				it "should show the correct form" do
					visit new_guild_path
					fill_in "guild_name", :with => "something"
					fill_in "guild_initials", :with => "something"
					click_button "Create new Guild"
					page.should have_content "Disciplines can't be blank"
					#can't really test anything else, since the dropdowns are javascript generated
				end
			end
		end
	end
end
