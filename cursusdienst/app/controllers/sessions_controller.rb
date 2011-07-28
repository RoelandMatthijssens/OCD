class SessionsController < ApplicationController
  def new
    @errors = []
#    @session = Session.new
    @submit = "Sign in"
  end
  
  def create
    user = User.autenticate(params[:session][:user_name], params[:session][:password])
    if user.nil?
      @errors = ["hello"]
      flash.now[:error] = "Institute updated succesfully"
      render 'new'
    else
      #sign in user
    end
  end

end
