require 'spec_helper'

describe "DisciplinesTests" do
  describe "GET /disciplines_tests" do
    before(:each) do
      @fac = Factory(:faculty)
      @dis = Factory(:discipline)
      @second = Factory(:discipline)
      third = Factory(:discipline)
      @diss = [@dis, @second, third]
    end

    describe "succeeding tests" do
      it "should visit the disciplines page" do
        visit disciplines_path
      end

      it "index should contain all discipline" do
        visit disciplines_path
        @diss.each { |i|
          has_content?(i.name).should be_true
        }
      end

      it "should go to an discipline when discipline name is clicked" do
        visit disciplines_path
        has_link? (@dis.name).should be_true
        click_link(@dis.name)
        page.should have_content(@dis.name)
        page.should have_link("Edit")
      end

      it "should have a new page" do
        visit new_discipline_path
        page.should have_content("new")
        page.should have_field("discipline_name")
        page.should have_select("discipline_faculty_id")
      end

      it "should create a new discipline" do
        visit new_discipline_path
        fill_in "discipline_name", :with => 'Compu We'
        select @dis.faculty.name, :from => 'discipline_faculty_id'
        click_button "Create"
        page.should have_content("Discipline created succesfully")
        page.should have_content("Compu We")
        page.should have_content(@dis.faculty.name)
      end

      it "should update an existing discipline" do
        visit disciplines_path
        click_link_or_button(@dis.name)
        click_link_or_button("Edit")
        page.should have_field("discipline_name", :with => @dis.name)
        fill_in "discipline_name", :with => 'Compu We'
        select @fac.full_name, :from => 'discipline_faculty_id'
        click_button "Update"
        page.should have_content("Discipline updated succesfully")
        page.should have_content("Compu We")
        page.should have_content(@fac.name)
      end
    end
    describe "failing tests" do
      describe "create new" do
        it "should NOT create a new discipline given blank name" do
          visit new_discipline_path
          fill_in "discipline_name", :with => ''
          select @fac.full_name, :from => 'discipline_faculty_id'
          click_button "Create"
          page.should have_content("Name can't be blank")
          page.should have_select("discipline_faculty_id", :selected => @fac.full_name)
        end


        it "should NOT create a new discipline given blank faculty" do
          visit new_discipline_path
          fill_in "discipline_name", :with => 'Compu We'
          click_button "Create"
          page.should have_content("Faculty can't be blank")
          page.should have_field("discipline_name", :with => "Compu We")
        end

        it "should NOT create a new discipline with a name that already exists within faculty" do
          visit new_discipline_path
          fill_in "discipline_name", :with => @dis.name
          select @dis.faculty.full_name, :from => 'discipline_faculty_id'
          click_button "Create"
          page.should have_content("Name has already been taken")
          page.should have_field("discipline_name", :with => @dis.name)
          page.should have_select("discipline_faculty_id", :selected => @dis.faculty.full_name)
        end

      end

      describe "update existing" do
        it "should NOT update an discipline given blank name" do
          visit disciplines_path
          click_link_or_button(@dis.name)
          click_link_or_button("Edit")
          fill_in "discipline_name", :with => ''
          select @fac.full_name, :from => 'discipline_faculty_id'
          click_button "Update"
          page.should have_content("Name can't be blank")
          page.should have_select("discipline_faculty_id", :selected => @fac.full_name)
        end

        it "should NOT update an discipline with a name that already exists" do
          visit disciplines_path
          click_link_or_button(@dis.name)
          click_link_or_button("Edit")
          fill_in "discipline_name", :with => @second.name
          select @second.faculty.full_name, :from => 'discipline_faculty_id'
          click_button "Update"
          page.should have_content("Name has already been taken")
          page.should have_field("discipline_name", :with => @second.name)
          page.should have_select("discipline_faculty_id", :selected => @second.faculty.full_name)
        end
      end
    end
  end
end
