require 'spec_helper'

module SessionsTestsHelper
  def login(user)
    visit new_session_path
    fill_in "User name", :with => user.user_name
    fill_in "Password", :with => user.password
    click_button("Sign in")
  end
  
  def logout(user)
    visit signout_path
  end
end
