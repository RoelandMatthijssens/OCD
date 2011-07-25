require 'spec_helper'

describe "FacultiesTests" do
  describe "GET /faculties_tests" do
    before(:each) do
      @inst = Factory(:institute)
      @fac = Factory(:faculty)
      @second = Factory(:faculty)
      third = Factory(:faculty)
      @facs = [@fac, @second, third]
    end
    
    describe "succeeding tests" do
      it "should visit the faculties page" do
        visit faculties_path
      end

      it "index should contain all faculty" do
        visit faculties_path
        @facs.each { |i|
          has_content?(i.name).should be_true
        }
      end

      it "should go to an faculty when faculty name is clicked" do
        visit faculties_path
        has_link? (@fac.name).should be_true
        click_link(@fac.name)
        page.should have_content(@fac.name)
        page.should have_content(@fac.initials)
        page.should have_link("Edit")
      end

      it "should have a new page" do
        visit new_faculty_path
        page.should have_content("new")
        page.should have_field("faculty_name")
        page.should have_field("faculty_initials")
        page.should have_select("faculty_institute_id")
      end

      it "should create a new faculty" do
        visit new_faculty_path
        fill_in "faculty_name", :with => 'Compu We'
        fill_in "faculty_initials", :with => 'CW'
        select @fac.institute.name, :from => 'faculty_institute_id'
        click_button "Create"
        page.should have_content("Faculty created succesfully")
        page.should have_content("Compu We")
        page.should have_content(@fac.institute.name)
        page.should have_content('CW')
      end

      it "should update a existing faculty" do
        visit faculties_path
        click_link_or_button(@fac.name)
        click_link_or_button("Edit")
        page.should have_field("faculty_initials", :with => @fac.initials)
        page.should have_field("faculty_name", :with => @fac.name)
        fill_in "faculty_name", :with => 'Compu We'
        fill_in "faculty_initials", :with => 'CW'
        select @inst.name, :from => 'faculty_institute_id'
        click_button "Update"
        page.should have_content("Faculty updated succesfully")
        page.should have_content("Compu We")
        page.should have_content(@inst.name)
        page.should have_content('CW')
      end
    end
    describe "failing tests" do
      describe "create new" do
        it "should NOT create a new faculty given blank name" do
          visit new_faculty_path
          fill_in "faculty_name", :with => ''
          fill_in "faculty_initials", :with => 'UA'
          select @inst.name, :from => 'faculty_institute_id'
          click_button "Create"
          page.should have_content("Name can't be blank")
          page.should have_field("faculty_initials", :with => "UA")
          page.should have_select("faculty_institute_id", :selected => @inst.name)
        end

        it "should NOT create a new faculty given blank initials" do
          visit new_faculty_path
          fill_in "faculty_name", :with => 'Compu We'
          fill_in "faculty_initials", :with => ''
          select @inst.name, :from => 'faculty_institute_id'
          click_button "Create"
          page.should have_content("Initials can't be blank")
          page.should have_field("faculty_name", :with => "Compu We")
          page.should have_select("faculty_institute_id", :selected => @inst.name)
        end

        it "should NOT create a new faculty given blank intitute" do
          visit new_faculty_path
          fill_in "faculty_name", :with => 'Compu We'
          fill_in "faculty_initials", :with => 'CW'
          click_button "Create"
          page.should have_content("Institute can't be blank")
          page.should have_field("faculty_name", :with => "Compu We")
          page.should have_field("faculty_initials", :with => "CW")
        end

        it "should NOT create a new faculty with a name that already exists within institute" do
          visit new_faculty_path
          fill_in "faculty_name", :with => @fac.name
          fill_in "faculty_initials", :with => "BLA"
          select @fac.institute.name, :from => 'faculty_institute_id'
          click_button "Create"
          page.should have_content("Name has already been taken")
          page.should have_field("faculty_initials", :with => "BLA")
          page.should have_field("faculty_name", :with => @fac.name)
          page.should have_select("faculty_institute_id", :selected => @fac.institute.name)
        end
        
        it "should NOT create a new faculty with initials that already exists within institute" do
          visit new_faculty_path
          fill_in "faculty_name", :with => "BLA"
          fill_in "faculty_initials", :with => @fac.initials
          select @fac.institute.name, :from => 'faculty_institute_id'
          click_button "Create"
          page.should have_content("Initials has already been taken")
          page.should have_field("faculty_initials", :with => @fac.initials)
          page.should have_field("faculty_name", :with => "BLA")
          page.should have_select("faculty_institute_id", :selected => @fac.institute.name)
        end
      end

      describe "update existing" do
        it "should NOT update an faculty given blank name" do
          visit faculties_path
          click_link_or_button(@fac.name)
          click_link_or_button("Edit")
          fill_in "faculty_name", :with => ''
          fill_in "faculty_initials", :with => 'UA'
          select @inst.name, :from => 'faculty_institute_id'
          click_button "Update"
          page.should have_content("Name can't be blank")
          page.should have_field("faculty_initials", :with => "UA")
          page.should have_select("faculty_institute_id", :selected => @inst.name)
        end

        it "should NOT update an faculty given blank initials" do
          visit faculties_path
          click_link_or_button(@fac.name)
          click_link_or_button("Edit")
          fill_in "faculty_name", :with => 'Compu We'
          fill_in "faculty_initials", :with => ''
          select @inst.name, :from => 'faculty_institute_id'
          click_button "Update"
          page.should have_content("Initials can't be blank")
          page.should have_field("faculty_name", :with => "Compu We")
          page.should have_select("faculty_institute_id", :selected => @inst.name)
        end

        it "should NOT update an faculty with a name that already exists" do
          visit faculties_path
          click_link_or_button(@fac.name)
          click_link_or_button("Edit")
          fill_in "faculty_name", :with => @second.name
          fill_in "faculty_initials", :with => "BLA"
          select @second.institute.name, :from => 'faculty_institute_id'
          click_button "Update"
          page.should have_content("Name has already been taken")
          page.should have_field("faculty_initials", :with => "BLA")
          page.should have_field("faculty_name", :with => @second.name)
          page.should have_select("faculty_institute_id", :selected => @second.institute.name)
        end

        it "should NOT update an faculty with initials that already exists" do
          visit faculties_path
          click_link_or_button(@fac.name)
          click_link_or_button("Edit")
          fill_in "faculty_name", :with => "BLA"
          fill_in "faculty_initials", :with => @second.initials
          select @second.institute.name, :from => 'faculty_institute_id'
          click_button "Update"
          page.should have_content("Initials has already been taken")
          page.should have_field("faculty_initials", :with => @second.initials)
          page.should have_field("faculty_name", :with => "BLA")
          page.should have_select("faculty_institute_id", :selected => @second.institute.name)
        end
      end
    end
  end
end
