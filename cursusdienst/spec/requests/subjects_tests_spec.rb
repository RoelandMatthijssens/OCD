require 'spec_helper'
require 'helpers/subjects_tests_helper'
include SubjectsTestsHelper

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
			login(@user1)
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
			login(@user1)
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
				it "should ask for login" do
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
			login(@user1)
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
					page.should have_field "subject_name"
				end
			end
			describe "'subject/1'" do
				it "should show the correct subject" do
					visit subjects_path :id => @subject1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'subject/new'" do
				it "should ask for login" do
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
						page.should have_content("User updated succesfully")
						page.should have_content("something")
						@subject1.reload
						@subject.name.should == 'something'
					end
				end
			end
		end
	end
end


  #describe "GET /subjects_tests" do
    #before(:each) do
      #@dis = Factory(:discipline)
      #@dis2 = Factory(:discipline)
      #@sub = Factory(:subject)
      #@sub.disciplines << @dis
      #@second = Factory(:subject)
      #@second.disciplines << @dis
      #third = Factory(:subject)
      #@subs = [@sub, @second, third]
    #end

    #describe "succeeding tests" do
      #it "should visit the subjects page" do
        #visit subjects_path
      #end

      #it "index should contain all subject" do
        #visit subjects_path
        #@subs.each { |i|
          #has_content?(i.name).should be_true
          #i.disciplines.each { |d|
            #has_content?(d.name).should be_true
          #}
        #}
      #end

      #it "should go to an subject when subject name is clicked" do
        #visit subjects_path
        #has_link? (@sub.name).should be_true
        #click_link(@sub.name)
        #page.should have_content(@sub.name)
        #page.should have_link("Edit")
      #end

      #it "should have a new page" do
        #visit new_subject_path
        #page.should have_content("new")
        #page.should have_field("subject_name")
        #page.should have_link("add one")
      #end

      #it "TEST MANUAL: should create a new subject with one discipline"

      #it "should update a existing subject" do
        #visit subjects_path
        #click_link_or_button(@sub.name)
        #click_link_or_button("Edit")
        #page.should have_field("subject_name", :with => @sub.name)
        #fill_in "subject_name", :with => 'ICP2'
        #select @dis2.full_name, :from => 'subject_disciplines_attributes_0_id'
        #click_button "Update"
        #page.should have_content("Subject succesfully updated")
        #page.should have_content("ICP2")
        #page.should have_content(@dis2.name)
      #end
    #end
    #describe "failing tests" do
      #describe "create new" do
        #it "should NOT create a new subject given blank name" do
          #visit new_subject_path
          #fill_in "subject_name", :with => ''
          #click_button "Create"
          #page.should have_content("Name can't be blank")
        #end
      #end

      #describe "update existing" do
        #it "should NOT update an subject given blank name" do
          #visit subjects_path
          #click_link_or_button(@sub.name)
          #click_link_or_button("Edit")
          #fill_in "subject_name", :with => ''
          #select @dis.full_name, :from => 'subject_disciplines_attributes_0_id'
          #click_button "Update"
          #page.should have_content("Name can't be blank")
          #page.should have_select("subject_disciplines_attributes_0_id", :selected => @dis.full_name)
        #end

        #it "should NOT update an subject with a name that already exists within institute" do
          #visit subjects_path
          #click_link_or_button(@sub.name)
          #click_link_or_button("Edit")
          #fill_in "subject_name", :with => @second.name
          #select @dis.full_name, :from => 'subject_disciplines_attributes_0_id'
          #click_button "Update"
          #page.should have_content("Subject needs unique name per institute")
          #page.should have_field("subject_name", :with => @second.name)
          #page.should have_select("subject_disciplines_attributes_0_id", :selected => @dis.full_name)
        #end
      #end
    #end
  #end
#end
