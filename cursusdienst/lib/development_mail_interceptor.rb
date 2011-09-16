class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    message.to = "rik@tyca.be, fulgens.ailurus@gmail.com"
  end
end
