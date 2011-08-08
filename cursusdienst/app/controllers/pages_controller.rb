class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
		@title = "About"
  end

  def access_denied
		@title = "Access Denied"
  end

  def control_panel
		if !signed_in?
			deny_access
		elsif !current_user.can?("use_control_panel")
			redirect_to idiot_path
		else
			@title = "Control Panel"
		end
	end

end
