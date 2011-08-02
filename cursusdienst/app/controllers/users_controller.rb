class UsersController < ApplicationController
	
	before_filter :authenticate, :only => [:edit, :update]
	before_filter :correct_user, :only => [:edit, :update]
  def index
    @title = "Users"
    @users = User.paginate(:page => params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @submit = "Register"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:succes] = "Registration succesfull"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:succes] = "User updated succesfully"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
  end
 
 private
 
	def authenticate
		deny_access unless signed_in?
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

end
