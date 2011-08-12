require 'spec_helper'
#require 'helpers/permission_groups_helper_spec'
include PermissionGroupsHelper

describe "PermissionGroupsTests" do
	before(:each) do
		@permission_group1 = Factory(:permission_group)
		@permission_group2 = Factory(:permission_group)
		@permission_group3 = Factory(:permission_group)
		@user1 = Factory(:user)
		@permission_groups = [@permission_group1, @permission_group2, @permission_group3]
	end
	describe "while not logged in" do
		describe "GET" do
			describe "'permission_groups'" do
				it "should ask for login" do
					visit permission_groups_path
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'permission_group/1/edit'" do
				it "should ask for login" do
					visit edit_permission_group_path :id => @permission_group1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'permission_group/1'" do
				it "should ask for login" do
					visit permission_groups_path :id => @permission_group1.id
					page.should have_content "Please sign in to acces this page"
				end
			end
			describe "'permission_group/new'" do
				it "should ask for login" do
					visit new_permission_group_path
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
			describe "'permission_groups'" do
				it "should deny access" do
					visit permission_groups_path
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/1/edit'" do
				it "should deny access" do
					visit edit_permission_group_path :id => @permission_group1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/1'" do
				it "should deny access" do
					visit permission_groups_path :id => @permission_group1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/new'" do
				it "should deny access" do
					visit new_permission_group_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with view_permission_groups permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "view_permission_groups")
			@user1.permission_groups << p
			login(@user1)
		end
		describe "GET" do
			describe "'permission_groups'" do
				it "should list all permission_groups" do
					visit permission_groups_path
					@permission_groups.each do |permission_group|
						page.should have_content(permission_group.name)
					end
				end
				it "should paginate the permission_groups" do
					10.times do
						@permission_groups << Factory(:permission_group)
					end
					visit permission_groups_path
					page.should have_content("Previous")
					page.should have_content("Next")
					page.should have_link("2")
				end
				it "should go to a permission_group when permission_group name is clicked" do
					visit permission_groups_path
					page.should have_link(@permission_group1.name)
					click_link(@permission_group1.name)
					page.should have_content(@permission_group1.name)
					page.should have_link("Edit")
				end
			end
			describe "'permission_group/1/edit'" do
				it "should deny access" do
					visit edit_permission_group_path :id => @permission_group1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/1'" do
				it "should show the correct permission_group" do
					visit permission_groups_path :id => @permission_group1.id
					page.should have_content @permission_group1.name
					
				end
			end
			describe "'permission_group/new'" do
				it "should deny access" do
					visit new_permission_group_path
					page.should have_content "Access Denied"
				end
			end
		end
	end
	describe "while logged in with edit_permission_groups permission" do
		before(:each) do
			p = PermissionGroup.create!(:name => "edit_permission_groups")
			@user1.permission_groups << p
			login(@user1)
		end
		describe "GET" do
			describe "'permission_groups'" do
				it "should deny access" do
					visit permission_groups_path
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/1/edit'" do
				it "show the correct edit page" do
					visit edit_permission_group_path :id => @permission_group1.id
					page.should have_field "permission_group_name"
				end
			end
			describe "'permission_group/1'" do
				it "should deny access" do
					visit permission_groups_path :id => @permission_group1.id
					page.should have_content "Access Denied"
				end
			end
			describe "'permission_group/new'" do
				it "should deny access" do
					visit new_permission_group_path
					page.should have_content "Access Denied"
				end
			end
		end
		describe "POST" do
			describe "'permission_group/1/update'" do
				before(:each) do
					visit edit_permission_group_path :id => @permission_group1.id
				end
				fields = ["permission_group_name"]
				fields.each do |field|
					it "should update the permission_group" do
						fill_in field, :with => 'something'
						click_button "Update Permission"
						#can't check the page, since i have no read access
						#check if the permission_group has actually changed instead
						@permission_group1.reload
						@permission_group1.name.should == 'something'
					end
				end
			end
		end
	end
end
