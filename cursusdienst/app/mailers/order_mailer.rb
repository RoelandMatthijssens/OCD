class OrderMailer < ActionMailer::Base
  default :from => "Cursusdienst.net <no-reply@cursusdienst.net>"
  
  def payment_info(user)
    @user = user
    mail( :to=>user.email, :subject => "Payment information")
  end
  
  def payment_ok(user)
    @user = user
    mail( :to=>"#{user.name} #{user.last_name} <#{user.email}>", :subject => "Payment received")
  end
end
