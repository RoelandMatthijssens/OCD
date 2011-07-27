class UsersController < ApplicationController

  def index
    @title = "Users"
    @users = User.all
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
end
