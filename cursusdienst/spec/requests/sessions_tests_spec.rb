require 'spec_helper'

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
#    it "schould log in with correct input " do
#      visit new_session_path
#      fill_in "session_user_name", :with => "Enermis"
#      fill_in "session_password", :with => "roeland1"
#      click_link_or_button("Sign in")
#    end
  end
  
  describe "POST 'create'" do
    describe "invalid signin" do
      before(:each) do
        visit new_session_path
        fill_in "session_user_name", :with => "Enermis"
        fill_in "session_password", :with => "INVALID"
        click_link_or_button("Sign in")
      end
      it "should re-render the new page" do
        page.should have_content("Sign in")
      end
      it "should show the warning" do
        page.should have_content("User name and Password do not match")
      end
    end
  end
end
