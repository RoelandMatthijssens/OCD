class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def about
		@title = "About"
  end

  def idiot
		redirect_to root_path unless signed_in?
		@title = "Don't be an idiot"
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
