class SessionsController < ApplicationController

  def new
    @errors = []
    @submit = "Sign in"
  end

  def create
    user = User.autenticate(params[:session][:user_name], params[:session][:password])
    if user.nil?
      @errors = [t(:password_mismatch, :scope => "flash" )]
      render 'new'
    else
      flash[:succes] =  t(:signed_in, :scope => "flash")
      sign_in user
      log "#{current_user.last_name} #{current_user.name} logged in"
      if session[:return_to]
        x = session[:return_to]
        clear_location
        redirect_to x
      elsif user.guilds.any?
        redirect_to root_url(:subdomain => user.guilds.first.initials)
      else
        redirect_to user
      end
    end
  end

  def destroy
    flash[:succes] =  t(:signed_out, :scope => "flash")
    sign_out
    redirect_to root_path
  end
end
