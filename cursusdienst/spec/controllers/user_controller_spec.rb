require 'spec_helper'

describe UsersController do
	describe "authentication of 'edit/update' pages" do
		before(:each) do
			@user = Factory(:user)
		end
		describe "non signed-in users" do
			it "should deny acces to 'edit'" do
				get :edit, :id => @user
				response.should redirect_to(signin_path)
			end
			it "should deny acces to 'update'" do
				put :update, :id => @user, :user => {}
				response.should redirect_to(signin_path)
			end
		end
	end
end
