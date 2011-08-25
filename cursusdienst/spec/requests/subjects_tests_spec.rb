require 'spec_helper'

describe "SubjectsTests" do

	before(:each) do
		@subject1 = Factory(:subject)
		@subject2 = Factory(:subject)
		@subject3 = Factory(:subject)
		@user1 = Factory(:user)
		@subjects = [@subject1, @subject2, @subject3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'subjects'" do
				it "should ask for login" do
					visit subjects_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'subject/1/edit'" do
				it "should ask for login" do
					visit edit_subject_path :id => @subject1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'subject/1'" do
				it "should ask for login" do
					visit subjects_path :id => @subject1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'subject/new'" do
				it "should ask for login" do
					visit new_subject_path
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
			describe "'subjects'" do
				it "should deny access" do
					visit subjects_path
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1/edit'" do
				it "should deny access" do
					visit edit_subject_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1'" do
				it "should deny access" do
					visit subjects_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/new'" do
				it "should deny access" do
					visit new_subject_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_subjects permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_subjects")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'subjects'" do
				it "should list all subjects" do
					visit subjects_path
					@subjects.each do |subject|
						page.should have_content(subject.name)
					end
				end
				it "should paginate the subjects" do
					10.times do
						@subjects << Factory(:subject)
					end
					visit subjects_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a subject when subject name is clicked" do
					visit subjects_path
					page.should have_link(@subject1.name)
					click_link(@subject1.name)
					page.should have_content(@subject1.name)
					page.should have_link("Edit")
				end
			end
			describe "'subject/1/edit'" do
				it "should deny access" do
					visit edit_subject_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1'" do
				it "should show the correct subject" do
					visit subjects_path :id => @subject1.id
					page.should have_content @subject1.name
					@subject1.disciplines.each do |discipline|
						page.should have_content discipline.name
						page.should have_content discipline.faculty.name
						page.should have_content discipline.faculty.institute.name
					end
					
				end
			end
			describe "'subject/new'" do
				it "should deny access" do
					visit new_subject_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_subjects permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_subjects")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'subjects'" do
				it "should deny access" do
					visit subjects_path
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1/edit'" do
				it "show the correct edit page" do
					visit edit_subject_path :id => @subject1.id
					page.should have_field "subject_name"
					page.should have_link "add one"
				end
			end
			describe "'subject/1'" do
				it "should deny access" do
					visit subjects_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/new'" do
				it "should deny access" do
					visit new_subject_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'subject/1/update'" do
				before(:each) do
					visit edit_subject_path :id => @subject1.id
				end
				fields = ["subject_name"]
				fields.each do |field|
					it "should update the subject" do
						fill_in field, :with => 'something'
						click_button "Update Subject"
						#can't check the page, since i have no read access
						#check if the subject has actually changed instead
						@subject1.reload
						@subject1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_subject permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_subjects")
			@user1.permission_groups << p
			#login(@user1)
			visit new_session_path
			fill_in "User name", :with => @user1.user_name
			fill_in "Password", :with => @user1.password
			click_button("Sign in")
		end
		describe "GET" do
			describe "'subjects'" do
				it "should deny access" do
					visit subjects_path
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1/edit'" do
				it "should deny access" do
					visit edit_subject_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/1'" do
				it "should deny access" do
					visit subjects_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/new'" do
				it "should show the correct form" do
					visit new_subject_path
					page.should have_field "subject_name"
				end
			end
		end
		describe "POST" do
			describe "'subject/1/update'" do
				it "should deny access" do
					visit edit_subject_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/new'" do
				it "should create a new subject" do
					lambda do
						visit new_subject_path
						fill_in "subject_name", :with => "something"
						fill_in "subject_year", :with => "1"
						fill_in "subject_year_type", :with => "something"
						click_link_or_button "Create new Subject"
						#can't check the page, since i have no read access
						#check if the subject was actually created instead
					end.should change(Subject, :count).by(1)
				end
			end
		end
	end

	#describe "javascript", :js => true do
		#it 'should show dropdowns when link is clicked' do
			#visit new_session_path
			#fill_in "User name", :with => @user1.user_name
			#fill_in "Password", :with => @user1.password
			#click_button("Sign in")
			
			#visit edit_subject_path :id => @subject1.id
			#save_and_open_page
			#click_link "add one"
			#page.should have_select "Institute"
			#page.should have_select "Faculty"
			#page.should have_select "Discipline"
		#end
	#end
end
