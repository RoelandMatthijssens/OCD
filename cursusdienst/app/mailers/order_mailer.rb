class OrderMailer < ActionMailer::Base
  default from: "no-reply@cursusdienst.net"
  
  def payment_info(user)
    @user = user
    mail( :to=>user.email, :subject => "Payment information")
  end
  
  def payment_ok(user)
    @user = user
    mail( :to=>user.email, :subject => "Payment received")
  end
end
