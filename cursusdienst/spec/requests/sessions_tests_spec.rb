require 'spec_helper'
require 'helpers/sessions_tests_helper'
include SessionsTestsHelper

describe "SessionsTests" do
  describe "GET 'new'" do
    it "should visit the login page session " do
      visit new_session_path
    end
    it "should have the correct fields on the login page " do
      visit new_session_path
      page.should have_field("session_user_name")
      page.should have_field("session_password")
    end
  end
  
  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        visit new_session_path
        fill_in "session_user_name", :with => "Example"
        fill_in "session_password", :with => "INVALID"
        click_link_or_button("Sign in")
      end
      it "should re-render the new page" do
        page.should have_content("Sign in")
      end
      it "should show the correct warning" do
        page.should have_content("User name - Password combination did not match")
      end
    end
    describe "valid signin" do
      before(:each) do
        @user = Factory(:user)
        login(@user)
      end
      it "should sign in the user" do
        page.should have_content("Successfully signed in")
      end
      it "should redirect to the homepage" do
        page.should have_content(@user.name)
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    before(:each) do
      @user = Factory(:user)
      login(@user)
#      visit auth_test_path
#      page.should have_content("Signed in as "+@user.name)
    end
    it "should log the user out" do
      
    end
  end
end
