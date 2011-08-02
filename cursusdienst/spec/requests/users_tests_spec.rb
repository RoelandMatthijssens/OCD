require 'spec_helper'

describe "UsersTests" do
  before(:each) do
    @user1 = Factory(:user)
    @user2 = Factory(:user)
    @user3 = Factory(:user)
    @users = [@user1, @user2, @user3]
  end
  describe "GET /users_tests" do
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
      
      it "should paginate the users" do
				30.times do
					@users << Factory(:user)
				end
				visit users_path
				page.should have_content("Previous")
				page.should have_content("Next")
				page.should have_link("2")
      end
    end
  end
  
  describe "POST 'new'" do
    describe "succeeding tests" do
      it "should have a new_user page" do
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

      describe "register" do
        it "should create a new user" do
          lambda do
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
          end.should change(User, :count).by(1)
        end
      end
    end
    
    describe "failing tests" do
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
          lambda do
            fill_in "user_"+field, :with => ''
            click_button "Register"
            page.should have_content(field.sub("_", " ").capitalize + " can't be blank")
          end.should_not change(User, :count)
        end
      end
      it "should NOT create a new user given a blank password" do
        lambda do
          fill_in "user_password", :with => ""
          click_button "Register"
          page.should have_content("Password can't be blank")
        end.should_not change(User, :count)
      end
      it "should NOT create a new user given a short password" do
        lambda do
          fill_in "user_password", :with => "12345"
          click_button "Register"
          page.should have_content("Password is too short")
        end.should_not change(User, :count)
      end
      it "should NOT create a new user given non-matching password-confirmation" do
        lambda do
          fill_in "user_password_confirmation", :with => ""
          click_button "Register"
          page.should have_content("Password doesn't match confirmation")
        end.should_not change(User, :count)
      end

      it "should NOT create a new user with a user_name that already exists" do
        lambda do
          fill_in "user_user_name", :with => @user1.user_name
          click_button "Register"
          page.should have_content("User name has already been taken")
          page.should have_field("user_user_name", :with => @user1.user_name)
        end.should_not change(User, :count)
      end
    end
  end
  
  describe "PUT 'update'" do
    describe 'succeeding tests' do
      before(:each) do
				visit new_session_path
				fill_in "session_user_name", :with => @user1.user_name
				fill_in "session_password", :with => @user1.password
				click_link_or_button("Sign in")
        visit users_path
        click_link_or_button(@user1.name)
        click_link_or_button("Edit")
        fill_in "user_last_name", :with => 'Matthijssens'
        fill_in "user_name", :with => 'Roeland'
        fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
      end
      it "should have the correct fields, filled in" do
				visit users_path
        click_link_or_button(@user1.name)
        click_link_or_button("Edit")
        page.should have_field("user_name", :with => @user1.name)
        page.should have_field("user_last_name", :with => @user1.last_name)
        page.should have_field("user_email", :with => @user1.email)
      end
      update_fields = ["name", "last_name"]
      update_fields.each do |field|
				it "should update #{field}" do
					fill_in "user_"+field, :with => "other_"+field
					click_link_or_button("Update")
					@user1.reload
					@user1.send(field).should == "other_"+field
					page.should have_content("User updated succesfully")
				end
			end
			it "should update the email field" do
				fill_in "user_email", :with => "other_email@email.email"
				click_link_or_button("Update")
				@user1.reload
				@user1.email.should == "other_email@email.email"
				page.should have_content("User updated succesfully")
			end
    end
    describe 'failing tests' do
      before(:each) do
				visit new_session_path
				fill_in "session_user_name", :with => @user1.user_name
				fill_in "session_password", :with => @user1.password
				click_link_or_button("Sign in")
        visit users_path
        click_link_or_button(@user1.name)
        click_link_or_button("Edit")
        fill_in "user_last_name", :with => 'Matthijssens'
        fill_in "user_name", :with => 'Roeland'
        fill_in "user_email", :with => 'fulgens.ailurus@gmail.com'
      end
      manditory_fields = ["name", "last_name", "email"]
      manditory_fields.each do |field|
        it "should NOT edit a user given blank manditory attributes" do
            fill_in "user_"+field, :with => ''
            click_button "Update User"
            page.should have_content(field.sub("_", " ").capitalize + " can't be blank")
        end
      end
    end
  end
end

