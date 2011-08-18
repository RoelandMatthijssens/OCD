require 'spec_helper'

describe "SubjectsTests" do
	before(:each) do
		@option1 = Factory(:option)
		@option2 = Factory(:option)
		@option3 = Factory(:option)
		@user1 = Factory(:user)
		@options = [@option1, @option2, @option3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'options'" do
				it "should ask for login" do
					visit options_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1/edit'" do
				it "should ask for login" do
					visit edit_option_path :id => @option1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1'" do
				it "should ask for login" do
					visit options_path :id => @option1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/new'" do
				it "should ask for login" do
					visit new_option_path
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
			describe "'options'" do
				it "should deny access" do
					visit options_path
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1/edit'" do
				it "should deny access" do
					visit edit_option_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1'" do
				it "should deny access" do
					visit options_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/new'" do
				it "should deny access" do
					visit new_option_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_options permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_options")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'options'" do
				it "should list all options" do
					visit options_path
					@options.each do |option|
						page.should have_content(option.name)
					end
				end
				it "should paginate the options" do
					10.times do
						@options << Factory(:option)
					end
					visit options_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a option when option name is clicked" do
					visit options_path
					page.should have_link(@option1.name)
					click_link(@option1.name)
					page.should have_content(@option1.name)
					page.should have_link("Edit")
				end
			end
			describe "'option/1/edit'" do
				it "should deny access" do
					visit edit_option_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1'" do
				it "should show the correct option" do
					visit options_path :id => @option1.id
					page.should have_content @option1.name
					@option1.materials.each do |material|
						page.should have_content material.name
					end
				end
			end
			describe "'option/new'" do
				it "should deny access" do
					visit new_option_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_options permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_options")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'options'" do
				it "should deny access" do
					visit options_path
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1/edit'" do
				it "show the correct edit page" do
					visit edit_option_path :id => @option1.id
					page.should have_field "option_name"
				end
			end
			describe "'option/1'" do
				it "should deny access" do
					visit options_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/new'" do
				it "should deny access" do
					visit new_option_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'option/1/update'" do
				before(:each) do
					visit edit_option_path :id => @option1.id
				end
				fields = ["option_name"]
				fields.each do |field|
					it "should update the option" do
						fill_in field, :with => 'something'
						click_button "Update Option"
						#can't check the page, since i have no read access
						#check if the option has actually changed instead
						@option1.reload
						@option1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_options permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_options")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'options'" do
				it "should deny access" do
					visit options_path
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1/edit'" do
				it "should deny access" do
					visit edit_option_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/1'" do
				it "should deny access" do
					visit options_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/new'" do
				it "should show the correct form" do
					visit new_option_path
					page.should have_field "option_name"
				end
			end
		end
		describe "POST" do
			describe "'option/1/update'" do
				it "should deny access" do
					visit edit_option_path :id => @option1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'option/new'" do
				it "create a new option" do
					lambda do
						visit new_option_path
						fill_in "option_name", :with => "something"
						click_link_or_button "Create new Option"
						#can't check the page, since i have no read access
						#check if the subject was actually created instead
					end.should change(Option, :count).by(1)
				end
			end
		end
	end
end
