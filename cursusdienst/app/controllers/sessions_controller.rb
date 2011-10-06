require 'digest'
require 'curl'

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
      elsif request.subdomain != "" && request.subdomain != "www"
        redirect_to Guild.find_by_initials(request.subdomain)
      else
        redirect_to user
      end
    end
  end

  def destroy
    flash[:succes] =  t(:signed_out, :scope => "flash")
    sign_out
    redirect_to root_url(:subdomain => 'www')
  end
  
  private
  
  def login_curl uname, pw
    c = Curl::Easy.new
    c.header_in_body = false
    c.ssl_verify_host = false
    c.follow_location = false
    c.url = "https://idsserve.vub.ac.be/cgi-bin/vrfy-pw"
    f = "username=" + c.escape(uname)
    f += "&password=" + c.escape(pw)
    f += "&failure=" + c.escape("http://igwe.vub.ac.be/failure")
    f += "&location=" + c.escape("http://igwe.vub.ac.be/success")
    f += "&fields=username&options=valid%20relation"
    c.http_post(f)
    c.body_str.index('success') ? true : false
    #   c.body_str.index('success') && true
  end
  
end
