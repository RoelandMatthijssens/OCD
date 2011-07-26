require 'spec_helper'
require 'helpers/subjects_tests_helper'
include SubjectsTestsHelper

describe "SubjectsTests" do
  describe "GET /subjects_tests" do
    before(:each) do
      @dis = Factory(:discipline)
      @dis2 = Factory(:discipline)
      @sub = Factory(:subject)
      @sub.disciplines << @dis
      @second = Factory(:subject)
      third = Factory(:subject)
      @subs = [@sub, @second, third]
    end

    describe "succeeding tests" do
      it "should visit the subjects page" do
        visit subjects_path
      end

      it "index should contain all subject" do
        visit subjects_path
        @subs.each { |i|
          has_content?(i.name).should be_true
          i.disciplines.each { |d|
            has_content?(d.name).should be_true
          }
        }
      end

      it "should go to an subject when subject name is clicked" do
        visit subjects_path
        has_link? (@sub.name).should be_true
        click_link(@sub.name)
        page.should have_content(@sub.name)
        page.should have_link("Edit")
      end

      it "should have a new page" do
        visit new_subject_path
        page.should have_content("new")
        page.should have_field("subject_name")
        page.should have_link("add one")
      end

      it "TEST MANUAL: should create a new subject with one discipline"

      it "should update a existing subject" do
        visit subjects_path
        click_link_or_button(@sub.name)
        click_link_or_button("Edit")
        page.should have_field("subject_name", :with => @sub.name)
        fill_in "subject_name", :with => 'ICP2'
        select @dis2.full_name, :from => 'subject_disciplines_attributes_0_id'
        click_button "Update"
        page.should have_content("Subject succesfully updated")
        page.should have_content("ICP2")
        page.should have_content(@dis2.name)
      end
    end
    describe "failing tests" do
      describe "create new" do
        it "should NOT create a new subject given blank name" do
          visit new_subject_path
          fill_in "subject_name", :with => ''
          click_button "Create"
          page.should have_content("Name can't be blank")
        end
      end

      describe "update existing" do
        it "should NOT update an subject given blank name" do
          visit subjects_path
          click_link_or_button(@sub.name)
          click_link_or_button("Edit")
          fill_in "subject_name", :with => ''
          select @dis.full_name, :from => 'subject_disciplines_attributes_0_id'
          click_button "Update"
          page.should have_content("Name can't be blank")
          page.should have_select("subject_disciplines_attributes_0_id", :selected => @dis.full_name)
        end

        it "should NOT update an subject with a name that already exists" do
          visit subjects_path
          click_link_or_button(@sub.name)
          click_link_or_button("Edit")
          fill_in "subject_name", :with => @second.name
          select @dis.full_name, :from => 'subject_disciplines_attributes_0_id'
          click_button "Update"
          page.should have_content("Name has already been taken")
          page.should have_field("subject_name", :with => @second.name)
          page.should have_select("subject_disciplines_attributes_0_id", @dis.full_name)
        end
      end
    end
  end
end
