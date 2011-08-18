require 'spec_helper'

describe "UsersTests" do
  before(:each) do
    @user1 = Factory(:user)
    @user2 = Factory(:user)
    @user3 = Factory(:user)
    @users = [@user1, @user2, @user3]
  end
  describe "while not logged in" do
		describe "GET" do
			describe "'users'" do
				it "should ask for login" do
					visit users_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'user/1/edit'" do
				it "should ask for login" do
					visit edit_user_path :id => @user1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'user/1'" do
				it "should ask for login" do
					visit users_path :id => @user1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'user/1/edit_permissions' self" do
				it "should ask for login" do
					visit edit_permissions_user_path :id => @user1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'user/new'" do
				it "should have a registration page" do
					visit new_user_path
					page.should have_content("Register")
					page.should have_field("user_name")
					page.should have_field("user_last_name")
					page.should have_field("user_user_name")
					page.should have_field("user_email")
					page.should have_field("user_password")
					page.should have_field("user_password_confirmation")
					page.should have_button("Register")
				end
			end
		end
		describe "POST" do
			before(:each) do
				visit new_user_path
			end
			describe "'users/create'" do
				it "should register with valid attributes, and forward to profile" do
					lambda do
						fill_in "user_user_name", :with => 'Fulgens'
						fill_in "user_last_name", :with => 'Matthijssens'
						fill_in "user_name", :with => 'Roeland'
						fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
						fill_in "user_password", :with => 'roeland1'
						fill_in "user_password_confirmation", :with => 'roeland1'
						click_button "Register"
						page.should have_content("Registration succesfull")
						page.should have_content("Fulgens")
					end.should change(User, :count).by(1)
				end
			end
		end
		describe "PUT" do
			describe "'users/1/update'"
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
			describe "'users'" do
				before(:each) do
					visit users_path
				end
				it "should deny access" do
					page.should have_content "Access Denied"
				end
			end
			describe "'user/2/edit' not self" do
				before(:each) do
					visit edit_user_path :id => @user2.id
				end
				it "should deny access" do
					page.should have_content "Access Denied"
				end
			end
			describe "'user/1/edit' self" do
				before(:each) do
					visit edit_user_path :id => @user1.id
				end
				it "should show correct fields" do
					page.should have_field("user_name")
					page.should have_field("user_last_name")
					page.should have_field("user_email")
					page.should have_button("Update User")
				end
			end
			describe "'user/2' not self" do
				before(:each) do
					visit user_path :id => @user2.id
				end
				it "should deny access" do
					page.should have_content "Access Denied"
				end
			end
			describe "'user/1' self" do
				before(:each) do
					visit user_path :id => @user1.id
				end
				it "should show the correct fields" do
					page.should have_content @user1.name
					page.should have_content @user1.last_name
					page.should have_content @user1.user_name
					page.should have_content @user1.email
				end
			end
			describe "'user/1/edit_permissions' self" do
				it "should deny access" do
					visit edit_permissions_user_path :id => @user1.id
					page.should have_content("Access Denied")
				end
			end
		end
		describe "POST" do
			describe "'user/1/update'" do
				before(:each) do
					visit edit_user_path :id => @user1.id
				end
				fields = ["name", "last_name", "email"]
				fields.each do |field|
					it "should update the user" do
						fill_in "user_"+field, :with => 'something@something.something'
						click_button "Update User"
						page.should have_content("User updated succesfully")
						page.should have_content("something@something.something")
						@user1.reload
						@user1.send(field).should == "something@something.something"
					end
				end
			end
		end
		describe "PUT" do
		end
	end
	describe "while logged in with view_users permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_users")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET 'users'" do
			before(:each) do
				visit users_path
			end
			it "should contain all users" do
				@users.each do |user|
					page.should have_content user.name
				end
			end
			it "should go to a user when the name is clicked" do
				page.should have_link(@user1.name)
				click_link @user1.name
				page.should have_content(@user1.name)
			end
			it "should paginate the users" do
				10.times do
					@users << Factory(:user)
				end
				visit users_path
				page.should have_content("Previous")
				page.should have_content("Next")
				page.should have_link("2")
			end
			describe "'user/2' not self" do
				it "should show the user" do
					visit user_path :id => @user2.id
					page.should have_content @user2.name
					page.should have_content @user2.last_name
					page.should have_content @user2.user_name
					page.should have_content @user2.email
				end
			end
			describe "'user/2/edit' not self" do
				before(:each) do
					visit edit_user_path :id => @user2.id
				end
				it "should deny access" do
					page.should have_content("Access Denied")
				end
			end
			describe "'user/1/edit_permissions' self" do
				it "should deny access" do
					visit edit_permissions_user_path :id => @user1.id
					page.should have_content("Access Denied")
				end
			end
		end
		describe "POST" do
		end
		describe "PUT" do
		end
	end
	describe "while logged in with edit_users permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_users")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'users'" do
				it "should deny access" do
					visit users_path
					page.should have_content "Access Denied"
				end
			end
			describe "'user/2/edit' not self" do
				it "should show the correct fields" do
					visit edit_user_path :id => @user2.id
					page.should have_field("user_name")
					page.should have_field("user_last_name")
					page.should have_field("user_email")
					page.should have_button("Update User")
				end
			end
			describe "'user/1/edit' self" do
				before(:each) do
					visit edit_user_path :id => @user1.id
				end
				it "should show correct fields" do
					page.should have_field("user_name")
					page.should have_field("user_last_name")
					page.should have_field("user_email")
					page.should have_button("Update User")
				end
			end
			describe "'user/2' not self" do
				before(:each) do
					visit user_path :id => @user2.id
				end
				it "should deny access" do
					page.should have_content "Access Denied"
				end
			end
			describe "'user/1' self" do
				before(:each) do
					visit user_path :id => @user1.id
				end
				it "show the user" do
					page.should have_content @user1.name
					page.should have_content @user1.last_name
					page.should have_content @user1.user_name
					page.should have_content @user1.email
				end
			end
			describe "'user/1/edit_permissions' self" do
				it "should deny access" do
					visit edit_permissions_user_path :id => @user1.id
					page.should have_content("Access Denied")
				end
			end
		end
		describe "POST" do
			describe "'users/create'"
		end
		describe "PUT" do
			describe "'users/1/update'"
		end
	end
	describe "while logged in with edit_permissions permissions" do
		before(:each) do
			p1 = PermissionGroup.create!(:name => 'edit_permissions')
			@user1.permission_groups << p1
			p2 = Factory(:permission_group)
			p3 = Factory(:permission_group)
			p4 = Factory(:permission_group)
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'users'" do
				it "should ask for login" do
					visit users_path
					page.should have_content "Access Denied"
				end
			end
			describe "'user/2/edit'" do
				it "should ask for login" do
					visit edit_user_path :id => @user2.id
					page.should have_content "Access Denied"
				end
			end
			describe "'user/2'" do
				it "should ask for login" do
					visit edit_user_path :id => @user2.id
					page.should have_content "Access Denied"
				end
			end
			describe "'user/1/edit_permissions' self" do
				it "should have all permissions listed" do
					visit edit_permissions_user_path :id => @user1.id
					PermissionGroup.all.each do |permission|
						page.should have_content(permission.name.gsub("_", " ") )
					end
				end
			end
			describe "'user/2/edit_permissions' not self" do
				it "should have all permissions listed" do
					visit edit_permissions_user_path :id => @user2.id
					PermissionGroup.all.each do |permission|
						page.should have_content(permission.name.gsub("_", " ") )
					end
				end
			end
		end
	end
end
