require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "cursusdienst.net",
  :user_name            => "noreply@cursusdienst.net",
  :password             => "jyH>M5FH",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "cursusdienst.net"
Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?