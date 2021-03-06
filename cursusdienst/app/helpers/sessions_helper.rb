module SessionsHelper
  def sign_in(user)
    cookies.permanent.signed[:remember_token] = {:value => [user.id, user.salt], :domain => :all}
    current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token, :domain => :all)
    current_user = nil
  end
  
	def current_user?(user)
		user == current_user
	end
	
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please sign in to acces this page"
	end

	def deny_privileged_access
		redirect_to access_denied_path, :notice => "You are not allowed to view this page"
	end
  
private
	def store_location
		session[:return_to] = request.fullpath
	end

	def clear_location
		session[:return_to] = nil
	end
	
  def user_from_remember_token
    User.autenticate_with_salt(*remember_token)
  end
  
  def remember_token
    cookies.signed[:remember_token] || {:value => [nil, nil], :domain => :all}
  end
end
