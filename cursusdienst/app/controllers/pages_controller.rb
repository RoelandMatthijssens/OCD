class PagesController < ApplicationController
  def home
		if signed_in? && current_user.guilds.any?
			redirect_to root_url(:subdomain => current_user.guilds[0].initials)
		end
		@title = t(:home, :scope => "titles" )
  end

  def about
		@title = t(:about, :scope => "titles" )
  end

  def access_denied
		@title = t(:access_denied, :scope => "titles" )
  end

  def control_panel
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('use_control_panel')
		@title = t(:control_panel2, :scope => "titles" )
	end

end
