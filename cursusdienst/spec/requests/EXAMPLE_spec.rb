#require 'spec_helper'
#
#describe "MaterialsTests" do
#  describe "GET /materials_tests" do
#    before(:each) do
#      @mat = Factory(:material)
#      @second = Factory(:material)#, :name => "Kat uni leuven", :initials => "KUL", :location => "Leuven")
#      third = Factory(:material)#, :name => "Uni Gent", :initials => "UG", :location => "Gent")
#      @mats = [@mat, @second, third]
#    end
#
#    describe "succeeding tests" do
#      it "should visit the materials page" do
#        visit materials_path
#      end
#
#      it "index should contain all material" do
#        visit materials_path
#        @mats.each { |i|
#          has_content?(i.name).should be_true
#        }
#      end
#
#      it "should go to an material when material name is clicked" do
#        visit materials_path
#        has_link? (@mat.name).should be_true
#        click_link(@mat.name)
#        page.should have_content(@mat.name)
#        page.should have_link("Edit")
#      end
#
#      it "should have a new page" do
#        visit new_material_path
#        page.should have_content("new")
#        page.should have_field("material_name")
#      end
#
#      it "should create a new material" do
#        visit new_material_path
#        fill_in "material_name", :with => 'Slides Test'
#        click_button "Create"
#        page.should have_content("Material succesfully created")
#        page.should have_content("Slides Test")
#      end
#
#      it "should update a existing material" do
#        visit materials_path
#        click_link_or_button(@mat.name)
#        click_link_or_button("Edit")
#        page.should have_field("material_name", :with => @mat.name)
#        fill_in "material_name", :with => 'Slides Test'
#        click_button "Update"
#        page.should have_content("Material updated succesfully")
#        page.should have_content("Slides Test")
#      end
#    end
#    describe "failing tests" do
#      describe "create new" do
#        it "should NOT create a new material given blank name" do
#          visit new_material_path
#          fill_in "material_name", :with => ''
#          click_button "Create"
#          page.should have_content("Name can't be blank")
#        end
#
#        it "should NOT create a new material with a name that already exists" do
#          visit new_material_path
#          fill_in "material_name", :with => @mat.name
#          click_button "Create"
#          page.should have_content("Name has already been taken")
#          page.should have_field("material_name", :with => @mat.name)
#        end
#      end
#
#      describe "update existing" do
#        it "should NOT update an material given blank name" do
#          visit materials_path
#          click_link_or_button(@mat.name)
#          click_link_or_button("Edit")
#          fill_in "material_name", :with => ''
#          click_button "Update"
#          page.should have_content("Name can't be blank")
#        end
#
#        it "should NOT update an material with a name that already exists" do
#          visit materials_path
#          click_link_or_button(@mat.name)
#          click_link_or_button("Edit")
#          fill_in "material_name", :with => @second.name
#          click_button "Update"
#          page.should have_content("Name has already been taken")
#          page.should have_field("material_name", :with => @second.name)
#        end
#      end
#    end
#  end
#end
