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
      flash[:succes] =  "Successfully signed in"
      sign_in user
      redirect_to user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
end
