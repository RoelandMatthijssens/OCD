require 'spec_helper'

describe "InstitutesTests" do
  describe "GET /institutes_tests" do
    before(:each) do
      @inst = Factory(:institute)
      @second = Factory(:institute)#, :name => "Kat uni leuven", :initials => "KUL", :location => "Leuven")
      third = Factory(:institute)#, :name => "Uni Gent", :initials => "UG", :location => "Gent")
      @insts = [@inst, @second, third]
    end
    
    describe "succeeding tests" do
      it "should visit the institutes page" do
        visit institutes_path
      end

      it "index should contain all institute" do
        visit institutes_path
        @insts.each { |i|
          has_content?(i.name).should be_true
        }
      end

      it "should go to an institute when institute name is clicked" do
        visit institutes_path
        has_link? (@inst.name).should be_true
        click_link(@inst.name)
        page.should have_content(@inst.name)
        page.should have_content(@inst.initials)
        page.should have_content(@inst.location)
        page.should have_link("Edit")
      end

      it "should have a new page" do
        visit new_institute_path
        page.should have_content("new")
        page.should have_field("institute_name")
        page.should have_field("institute_initials")
        page.should have_field("institute_location")
      end

      it "should create a new institute" do
        visit new_institute_path
        fill_in "institute_name", :with => 'Uni Antwerpen'
        fill_in "institute_initials", :with => 'UA'
        fill_in "institute_location", :with => 'Antwerpen'
        click_button "Create"
        page.should have_content("Institution create succesfully")
        page.should have_content("Uni Antwerpen")
        page.should have_content('UA')
        page.should have_content('Antwerpen')
      end

      it "should update a existing institute" do
        visit institutes_path
        click_link_or_button(@inst.name)
        click_link_or_button("Edit")
        page.should have_field("institute_location", :with => @inst.location)
        page.should have_field("institute_initials", :with => @inst.initials)
        page.should have_field("institute_name", :with => @inst.name)
        fill_in "institute_name", :with => 'Uni Antwerpen'
        fill_in "institute_initials", :with => 'UA'
        fill_in "institute_location", :with => 'Antwerpen'
        click_button "Update"
        page.should have_content("Institute updated succesfully")
        page.should have_content("Uni Antwerpen")
        page.should have_content('UA')
        page.should have_content('Antwerpen')
      end
    end
    describe "failing tests" do
      describe "create new" do
        it "should NOT create a new institute given blank name" do
          visit new_institute_path
          fill_in "institute_name", :with => ''
          fill_in "institute_initials", :with => 'UA'
          fill_in "institute_location", :with => 'Antwerpen'
          click_button "Create"
          page.should have_content("Name can't be blank")
          page.should have_field("institute_initials", :with => "UA")
          page.should have_field("institute_location", :with => "Antwerpen")
        end

        it "should NOT create a new institute given blank initials" do
          visit new_institute_path
          fill_in "institute_name", :with => 'Uni Antwerpen'
          fill_in "institute_initials", :with => ''
          fill_in "institute_location", :with => 'Antwerpen'
          click_button "Create"
          page.should have_content("Initials can't be blank")
          page.should have_field("institute_name", :with => "Uni Antwerpen")
          page.should have_field("institute_location", :with => "Antwerpen")
        end

        it "should NOT create a new institute given blank location" do
          visit new_institute_path
          fill_in "institute_name", :with => 'Uni Antwerpen'
          fill_in "institute_initials", :with => 'UA'
          fill_in "institute_location", :with => ''
          click_button "Create"
          page.should have_content("Location can't be blank")
          page.should have_field("institute_initials", :with => "UA")
          page.should have_field("institute_name", :with => "Uni Antwerpen")
        end

        it "should NOT create a new institute with a name that already exists" do
          visit new_institute_path
          fill_in "institute_name", :with => @inst.name
          fill_in "institute_initials", :with => "BLA"
          fill_in "institute_location", :with => @inst.location
          click_button "Create"
          page.should have_content("Name has already been taken")
          page.should have_field("institute_location", :with => @inst.location)
          page.should have_field("institute_initials", :with => "BLA")
          page.should have_field("institute_name", :with => @inst.name)
        end
        
        it "should NOT create a new institute with initials that already exists" do
          visit new_institute_path
          fill_in "institute_name", :with => "BLA"
          fill_in "institute_initials", :with => @inst.initials
          fill_in "institute_location", :with => @inst.location
          click_button "Create"
          page.should have_content("Initials has already been taken")
          page.should have_field("institute_location", :with => @inst.location)
          page.should have_field("institute_initials", :with => @inst.initials)
          page.should have_field("institute_name", :with => "BLA")
        end
      end

      describe "update existing" do
        it "should NOT update an institute given blank name" do
          visit institutes_path
          click_link_or_button(@inst.name)
          click_link_or_button("Edit")
          fill_in "institute_name", :with => ''
          fill_in "institute_initials", :with => 'UA'
          fill_in "institute_location", :with => 'Antwerpen'
          click_button "Update"
          page.should have_content("Name can't be blank")
          page.should have_field("institute_initials", :with => "UA")
          page.should have_field("institute_location", :with => "Antwerpen")
        end

        it "should NOT update an institute given blank initials" do
          visit institutes_path
          click_link_or_button(@inst.name)
          click_link_or_button("Edit")
          fill_in "institute_name", :with => 'Uni Antwerpen'
          fill_in "institute_initials", :with => ''
          fill_in "institute_location", :with => 'Antwerpen'
          click_button "Update"
          page.should have_content("Initials can't be blank")
          page.should have_field("institute_name", :with => "Uni Antwerpen")
          page.should have_field("institute_location", :with => "Antwerpen")
        end

        it "should NOT update an institute given blank location" do
          visit institutes_path
          click_link_or_button(@inst.name)
          click_link_or_button("Edit")
          fill_in "institute_name", :with => 'Uni Antwerpen'
          fill_in "institute_initials", :with => 'UA'
          fill_in "institute_location", :with => ''
          click_button "Update"
          page.should have_content("Location can't be blank")
          page.should have_field("institute_initials", :with => "UA")
          page.should have_field("institute_name", :with => "Uni Antwerpen")
        end

        it "should NOT update an institute with a name that already exists" do
          visit institutes_path
          click_link_or_button(@inst.name)
          click_link_or_button("Edit")
          fill_in "institute_name", :with => @second.name
          fill_in "institute_initials", :with => "BLA"
          fill_in "institute_location", :with => @second.location
          click_button "Update"
          page.should have_content("Name has already been taken")
          page.should have_field("institute_location", :with => @second.location)
          page.should have_field("institute_initials", :with => "BLA")
          page.should have_field("institute_name", :with => @second.name)
        end

        it "should NOT update an institute with initials that already exists" do
          visit institutes_path
          click_link_or_button(@inst.name)
          click_link_or_button("Edit")
          fill_in "institute_name", :with => "BLA"
          fill_in "institute_initials", :with => @second.initials
          fill_in "institute_location", :with => @second.location
          click_button "Update"
          page.should have_content("Initials has already been taken")
          page.should have_field("institute_location", :with => @second.location)
          page.should have_field("institute_initials", :with => @second.initials)
          page.should have_field("institute_name", :with => "BLA")
        end
      end
    end
  end
end
