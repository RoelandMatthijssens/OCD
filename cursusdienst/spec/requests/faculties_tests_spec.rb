require 'spec_helper'

describe "FacultiesTests" do
	before(:each) do
		@faculty1 = Factory(:faculty)
		@faculty2 = Factory(:faculty)
		@faculty3 = Factory(:faculty)
		@user1 = Factory(:user)
		@discipline = Factory(:discipline)
		@faculties = [@faculty1, @faculty2, @faculty3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'faculties'" do
				it "should ask for login" do
					visit faculties_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1/edit'" do
				it "should ask for login" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'faculty/1'" do
				it "should ask for login" do
					visit faculties_path :id => @faculty1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'faculty/new'" do
				it "should ask for login" do
					visit new_faculty_path
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
			describe "'faculties'" do
				it "should deny access" do
					visit faculties_path
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1/edit'" do
				it "should deny access" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1'" do
				it "should deny access" do
					visit faculties_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/new'" do
				it "should deny access" do
					visit new_faculty_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_faculties permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_faculties")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'faculties'" do
				it "should list all faculties" do
					visit faculties_path
					@faculties.each do |faculty|
						page.should have_content(faculty.name)
					end
				end
				it "should paginate the faculties" do
					10.times do
						@faculties << Factory(:faculty)
					end
					visit faculties_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a faculty when faculty name is clicked" do
					visit faculties_path
					page.should have_link(@faculty1.name)
					click_link(@faculty1.name)
					page.should have_content(@faculty1.name)
					page.should have_link("Edit")
				end
			end
			describe "'faculty/1/edit'" do
				it "should deny access" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1'" do
				it "should show the correct faculty" do
					visit faculties_path :id => @faculty1.id
					page.should have_content @faculty1.name
					@faculty1.disciplines.each do |discipline|
						page.should have_content discipline.name
					end
				end
			end
			describe "'faculty/new'" do
				it "should deny access" do
					visit new_faculty_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_faculties permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_faculties")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'faculties'" do
				it "should deny access" do
					visit faculties_path
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1/edit'" do
				it "show the correct edit page" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_field "faculty_name"
				end
			end
			describe "'faculty/1'" do
				it "should deny access" do
					visit faculties_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/new'" do
				it "should deny access" do
					visit new_faculty_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'faculty/1/update'" do
				before(:each) do
					visit edit_faculty_path :id => @faculty1.id
				end
				fields = ["faculty_name"]
				fields.each do |field|
					it "should update the faculty" do
						fill_in field, :with => 'something'
						click_button "Update Faculty"
						#can't check the page, since i have no read access
						#check if the faculty has actually changed instead
						@faculty1.reload
						@faculty1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_faculties permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_faculties")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'faculties'" do
				it "should deny access" do
					visit faculties_path
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1/edit'" do
				it "should deny access" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/1'" do
				it "should deny access" do
					visit faculties_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/new'" do
				it "should show the correct form" do
					visit new_faculty_path
					page.should have_field "faculty_name"
					page.should have_field "faculty_initials"
				end
			end
		end
		describe "POST" do
			describe "'faculty/1/update'" do
				it "should deny access" do
					visit edit_faculty_path :id => @faculty1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'faculty/new'" do
				it "should show the correct form" do
					visit new_faculty_path
					fill_in "faculty_name", :with => "something"
					click_button "Create new Faculty"
					page.should have_content "Institute can't be blank"
					#can't really test anything else, since the dropdowns are javascript generated
				end
			end
		end
	end
end
