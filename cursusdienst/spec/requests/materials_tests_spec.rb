require 'spec_helper'

describe "MaterialsTests" do
	before(:each) do
		@material1 = Factory(:material)
		@material2 = Factory(:material)
		@material3 = Factory(:material)
		@user1 = Factory(:user)
		@materials = [@material1, @material2, @material3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'materials'" do
				it "should ask for login" do
					visit materials_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'option/1/edit'" do
				it "should ask for login" do
					visit edit_material_path :id => @material1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'material/1'" do
				it "should ask for login" do
					visit materials_path :id => @material1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'material/new'" do
				it "should ask for login" do
					visit new_material_path
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
			describe "'materials'" do
				it "should deny access" do
					visit materials_path
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1/edit'" do
				it "should deny access" do
					visit edit_material_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1'" do
				it "should deny access" do
					visit materials_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/new'" do
				it "should deny access" do
					visit new_material_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_materials permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_materials")
			@user1.permission_groups << p
			login(@user1)
		end
		describe "GET" do
			describe "'materials'" do
				it "should list all materials" do
					visit materials_path
					@materials.each do |material|
						page.should have_content(material.name)
					end
				end
				it "should paginate the materials" do
					10.times do
						@materials << Factory(:material)
					end
					visit materials_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a material when material name is clicked" do
					visit materials_path
					page.should have_link(@material1.name)
					click_link(@material1.name)
					page.should have_content(@material1.name)
					page.should have_link("Edit")
				end
			end
			describe "'material/1/edit'" do
				it "should deny access" do
					visit edit_material_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1'" do
				it "should show the correct material" do
					visit materials_path :id => @material1.id
					page.should have_content @material1.name
					@material1.options.each do |option|
						page.should have_content option.name
					end
				end
			end
			describe "'material/new'" do
				it "should deny access" do
					visit new_material_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_materials permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_materials")
			@user1.permission_groups << p
			login(@user1)
		end
		describe "GET" do
			describe "'materials'" do
				it "should deny access" do
					visit materials_path
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1/edit'" do
				it "show the correct edit page" do
					visit edit_material_path :id => @material1.id
					page.should have_field "material_name"
				end
			end
			describe "'material/1'" do
				it "should deny access" do
					visit materials_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/new'" do
				it "should deny access" do
					visit new_material_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'material/1/update'" do
				before(:each) do
					visit edit_material_path :id => @material1.id
				end
				fields = ["material_name"]
				fields.each do |field|
					it "should update the material" do
						fill_in field, :with => 'something'
						click_button "Update Material"
						#can't check the page, since i have no read access
						#check if the material has actually changed instead
						@material1.reload
						@material1.name.should == 'something'
					end
				end
			end
		end
	end
	describe "while logged in with create_materials permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "create_materials")
			@user1.permission_groups << p
			login(@user1)
		end
		describe "GET" do
			describe "'materials'" do
				it "should deny access" do
					visit materials_path
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1/edit'" do
				it "should deny access" do
					visit edit_material_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/1'" do
				it "should deny access" do
					visit materials_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/new'" do
				it "should show the correct form" do
					visit new_material_path
					page.should have_field "material_name"
				end
			end
		end
		describe "POST" do
			describe "'material/1/update'" do
				it "should deny access" do
					visit edit_material_path :id => @material1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'material/new'" do
				it "create a new material" do
					lambda do
						visit new_material_path
						fill_in "material_name", :with => "something"
						click_link_or_button "Create new Material"
						#can't check the page, since i have no read access
						#check if the subject was actually created instead
					end.should change(Material, :count).by(1)
				end
			end
		end
	end
end
