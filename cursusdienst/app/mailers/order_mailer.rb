class OrderMailer < ActionMailer::Base
  default :from => "Cursusdienst.net <noreply@cursusdienst.net>"
  
  def payment_info(user)
    @user = user
    mail( :to=>user.email, :subject => "Payment information")
  end
  
  def payment_ok(order)
    @order = order
    @user = @order.user
    attachments.inline['cd_logo.gif'] = File.read("#{Rails.root}/public/mails/images/cd_logo.gif")
    mail( :to=>"#{@user.name} #{@user.last_name} <#{@user.email}>", :subject => "Payment received")
  end
  
  def order_ready(order)
    @order = order
    @user = @order.user
    attachments.inline['cd_logo.gif'] = File.read("#{Rails.root}/public/mails/images/cd_logo.gif")
    mail( :to=>"#{@user.name} #{@user.last_name} <#{@user.email}>", :subject => "Payment received")
  end
end
