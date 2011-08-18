require 'spec_helper'

describe "DisciplinesTests" do
  before(:each) do
		@discipline1 = Factory(:discipline)
		@discipline2 = Factory(:discipline)
		@discipline3 = Factory(:discipline)
		@user1 = Factory(:user)
		@disciplines = [@discipline1, @discipline2, @discipline3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'disciplines'" do
				it "should ask for login" do
					visit disciplines_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'discipline/1/edit'" do
				it "should ask for login" do
					visit edit_discipline_path :id => @discipline1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'discipline/1'" do
				it "should ask for login" do
					visit disciplines_path :id => @discipline1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'discipline/new'" do
				it "should ask for login" do
					visit new_discipline_path
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
			describe "'disciplines'" do
				it "should deny access" do
					visit disciplines_path
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/1/edit'" do
				it "should deny access" do
					visit edit_discipline_path :id => @discipline1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/1'" do
				it "should deny access" do
					visit disciplines_path :id => @discipline1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/new'" do
				it "should deny access" do
					visit new_discipline_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_disciplines permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_disciplines")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'disciplines'" do
				it "should list all disciplines" do
					visit disciplines_path
					@disciplines.each do |discipline|
						page.should have_content(discipline.name)
					end
				end
				it "should paginate the disciplines" do
					10.times do
						@disciplines << Factory(:discipline)
					end
					visit disciplines_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a discipline when discipline name is clicked" do
					visit disciplines_path
					page.should have_link(@discipline1.name)
					click_link(@discipline1.name)
					page.should have_content(@discipline1.name)
					page.should have_link("Edit")
				end
			end
			describe "'discipline/1/edit'" do
				it "should deny access" do
					visit edit_discipline_path :id => @discipline1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/1'" do
				it "should show the correct discipline" do
					visit disciplines_path :id => @discipline1.id
					page.should have_content @discipline1.name
					page.should have_content @discipline1.faculty.name
					page.should have_content @discipline1.faculty.institute.name
					
				end
			end
			describe "'discipline/new'" do
				it "should deny access" do
					visit new_discipline_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_disciplines permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_disciplines")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'disciplines'" do
				it "should deny access" do
					visit disciplines_path
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/1/edit'" do
				it "show the edit page" do
					visit edit_discipline_path :id => @discipline1.id
					page.should have_field "discipline_name"
				end
			end
			describe "'discipline/1'" do
				it "should deny access" do
					visit disciplines_path :id => @discipline1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'discipline/new'" do
				it "deny access" do
					visit new_discipline_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'discipline/1/update'" do
				before(:each) do
					visit edit_discipline_path :id => @discipline1.id
				end
				fields = ["discipline_name"]
				fields.each do |field|
					it "should update the discipline" do
						fill_in field, :with => 'something'
						click_button "Update Discipline"
						#can't check the page, since i have no read access
						#check if the discipline has actually changed instead
						@discipline1.reload
						@discipline1.name.should == 'something'
					end
				end
			end
		end
	end
end
