class SessionsController < ApplicationController
  
  def new
    @errors = []
    @submit = "Sign in"
  end
  
  def create
    user = User.autenticate(params[:session][:user_name], params[:session][:password])
    if user.nil?
      @errors = ["User name - Password combination did not match"]
      render 'new'
    else
      flash[:succes] =  t(:signed_in, :scope => "flash.message")
      sign_in user
      if session[:return_to]
				x = session[:return_to]
				clear_location
				redirect_to x
			elsif user.guilds.any?
				redirect_to user.guilds.first
			else
				redirect_to user
			end
    end
  end
  
  def destroy
    flash[:succes] =  t(:signed_out, :scope => "flash.message")
    sign_out
    redirect_to root_path
  end
end
