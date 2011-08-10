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
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('use_control_panel')
		@title = 'Control Panel'
	end

end
