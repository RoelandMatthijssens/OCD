require 'spec_helper'

describe "UsersTests" do
  describe "GET /users_tests" do
    before(:each) do
      @user1 = Factory(:user)
      @user2 = Factory(:user)
      @user3 = Factory(:user)
      @users = [@user1, @user2, @user3]
    end

    describe "succeeding tests" do
      it "should visit the users page" do
        visit users_path
      end

      it "index should contain all users" do
        visit users_path
        @users.each { |i|
          has_content?(i.name).should be_true
        }
      end

      it "should go to a user when user name is clicked" do
        visit users_path
        has_link? (@user1.name).should be_true
        click_link(@user1.name)
        page.should have_content(@user1.name)
        page.should have_link("Edit")
      end

      it "should have a new page" do
        visit new_user_path
        page.should have_content("Register")
        page.should have_field("user_name")
        page.should have_field("user_last_name")
        page.should have_field("user_user_name")
        page.should have_field("user_email")
        page.should have_field("user_password")
        page.should have_field("user_password_confirmation")
        page.should have_button("Register")
      end

      it "should create a new user" do
        count = User.count
        visit new_user_path
        fill_in "user_user_name", :with => 'Fulgens'
        fill_in "user_last_name", :with => 'Matthijssens'
        fill_in "user_name", :with => 'Roeland'
        fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
        fill_in "user_password", :with => 'roeland1'
        fill_in "user_password_confirmation", :with => 'roeland1'
        click_button "Register"
        page.should have_content("Registration succesfull")
        page.should have_content("Fulgens")
        User.count.should == count + 1
      end

#      describe "update" do
#        before(:each) do
#          visit users_path
#          click_link_or_button(@user1.name)
#          click_link_or_button("Edit")
#        end
#        it "should have the correct fields" do
#          page.should have_field("user_name", :with => @user1.name)
#          page.should have_field("user_last_name", :with => @user1.last_name)
#          page.should have_field("user_email", :with => @user1.email)
#          page.should have_field("user_password", :type => "password")
#          page.should have_field("user_password_confirmation", :type => "password")
#        end
#        it "should update the name" do
#          fill_in "user_name", :with => 'Rik'
#          click_button "Update"
#          page.should have_content("User updated succesfully")
#          page.should have_content("Rik")
#        end
#        it "should update the last_name" do
#          fill_in "user_last_name", :with => 'Van Mechele'
#          click_button "Update"
#          page.should have_content("User updated succesfully")
#          page.should have_content("Van Mechele")
#        end
#        it "should update the last_name" do
#          fill_in "user_email", :with => 'Rik_Van_Mechele@gmail.com'
#          click_button "Update"
#          page.should have_content("User updated succesfully")
#          page.should have_content("Rik_Van_Mechele@gmail.com")
#        end
#      end
    end
    describe "failing tests" do
      describe "create new" do
        before(:each) do
          visit new_user_path
          fill_in "user_user_name", :with => 'Fulgens'
          fill_in "user_last_name", :with => 'Matthijssens'
          fill_in "user_name", :with => 'Roeland'
          fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
          fill_in "user_password", :with => 'roeland1'
          fill_in "user_password_confirmation", :with => 'roeland1'
        end
        manditory_fields = ["user_name", "name", "last_name", "email"]
        manditory_fields.each do |field|
          it "should NOT create a new user given blank manditory attributes" do
              fill_in "user_"+field, :with => ''
              click_button "Register"
              page.should have_content(field.sub("_", " ").capitalize + " can't be blank")
          end
        end
        it "should NOT create a new user given a blank password" do
          fill_in "user_password", :with => ""
          click_button "Register"
          page.should have_content("Password can't be blank")
        end
        it "should NOT create a new user given a short password" do
          fill_in "user_password", :with => "12345"
          click_button "Register"
          page.should have_content("Password is too short")
        end
        it "should NOT create a new user given non-matching password-confirmation" do
          fill_in "user_password_confirmation", :with => ""
          click_button "Register"
          page.should have_content("Password doesn't match confirmation")
        end

        it "should NOT create a new user with a user_name that already exists" do
          fill_in "user_user_name", :with => @user1.user_name
          click_button "Register"
          page.should have_content("User name has already been taken")
          page.should have_field("user_user_name", :with => @user1.user_name)
        end
      end

#      describe "update existing" do
#        before(:each) do
#          visit users_path
#          click_link_or_button(@user1.name)
#          click_link_or_button("Edit")
#          fill_in "user_last_name", :with => 'Matthijssens'
#          fill_in "user_name", :with => 'Roeland'
#          fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
#          fill_in "user_password", :with => 'roeland1'
#          fill_in "user_password_confirmation", :with => 'roeland1'
#        end
#        manditory_fields = ["name", "last_name", "email"]
#        manditory_fields.each do |field|
#          it "should NOT create a new user given blank manditory attributes" do
#              fill_in "user_"+field, :with => ''
#              click_button "Register"
#              page.should have_content(field.sub("_", " ").capitalize + " can't be blank")
#          end
#        end
#        it "should NOT update an material given blank name" do
#          fill_in "material_name", :with => ''
#          click_button "Update"
#          page.should have_content("Name can't be blank")
#        end

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
    end
  end
end
