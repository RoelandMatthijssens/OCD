require 'spec_helper'

describe "InstitutesTests" do
	before(:each) do
		@institute1 = Factory(:institute)
		@institute2 = Factory(:institute)
		@institute3 = Factory(:institute)
		@user1 = Factory(:user)
		@institutes = [@institute1, @institute2, @institute3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'institutes'" do
				it "should ask for login" do
					visit institutes_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1/edit'" do
				it "should ask for login" do
					visit edit_institute_path :id => @institute1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'institute/1'" do
				it "should ask for login" do
					visit institutes_path :id => @institute1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'institute/new'" do
				it "should ask for login" do
					visit new_institute_path
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
			describe "'institutes'" do
				it "should deny access" do
					visit institutes_path
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1/edit'" do
				it "should deny access" do
					visit edit_institute_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1'" do
				it "should deny access" do
					visit institutes_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/new'" do
				it "should deny access" do
					visit new_institute_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_institutes permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_institutes")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'institutes'" do
				it "should list all institutes" do
					visit institutes_path
					@institutes.each do |institute|
						page.should have_content(institute.name)
					end
				end
				it "should paginate the institutes" do
					10.times do
						@institutes << Factory(:institute)
					end
					visit institutes_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a institute when institute name is clicked" do
					visit institutes_path
					page.should have_link(@institute1.name)
					click_link(@institute1.name)
					page.should have_content(@institute1.name)
					page.should have_link("Edit")
				end
			end
			describe "'institute/1/edit'" do
				it "should deny access" do
					visit edit_institute_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1'" do
				it "should show the correct institute" do
					visit institutes_path :id => @institute1.id
					page.should have_content @institute1.name
					@institute1.faculties.each do |faculty|
						page.should have_content faculty.name
					end
				end
			end
			describe "'institute/new'" do
				it "should deny access" do
					visit new_institute_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_institutes permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_institutes")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'institutes'" do
				it "should deny access" do
					visit institutes_path
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1/edit'" do
				it "show the correct edit page" do
					visit edit_institute_path :id => @institute1.id
					page.should have_field "institute_name"
				end
			end
			describe "'institute/1'" do
				it "should deny access" do
					visit institutes_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/new'" do
				it "should deny access" do
					visit new_institute_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'institute/1/update'" do
				before(:each) do
					visit edit_institute_path :id => @institute1.id
				end
				fields = ["institute_name"]
				fields.each do |field|
					it "should update the institute" do
						fill_in field, :with => 'something'
						click_button "Update Institute"
						#can't check the page, since i have no read access
						#check if the institute has actually changed instead
						@institute1.reload
						@institute1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_institutes permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_institutes")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'institutes'" do
				it "should deny access" do
					visit institutes_path
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1/edit'" do
				it "should deny access" do
					visit edit_institute_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/1'" do
				it "should deny access" do
					visit institutes_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/new'" do
				it "should show the correct form" do
					visit new_institute_path
					page.should have_field "institute_name"
					page.should have_field "institute_initials"
					page.should have_field "institute_location"
				end
			end
		end
		describe "POST" do
			describe "'institute/1/update'" do
				it "should deny access" do
					visit edit_institute_path :id => @institute1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'institute/new'" do
				it "create a new institute" do
					lambda do
						visit new_institute_path
						fill_in "institute_name", :with => "something"
						fill_in "institute_initials", :with => "something"
						fill_in "institute_location", :with => "something"
						click_link_or_button "Create new Institute"
						#can't check the page, since i have no read access
						#check if the subject was actually created instead
					end.should change(Institute, :count).by(1)
				end
			end
		end
	end
end
