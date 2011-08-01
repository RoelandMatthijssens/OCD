require 'spec_helper'

module SessionsTestsHelper
  def login(user)
    visit new_session_path
    fill_in "session_user_name", :with => user.user_name
    fill_in "session_password", :with => user.password
    click_link_or_button("Sign in")
  end
  
  def logout(user)
    visit destroy_session_path
  end
end
