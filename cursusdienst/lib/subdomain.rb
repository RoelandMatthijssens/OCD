class Subdomain  
  def self.matches?(request)  
    request.subdomain(2).present? && request.subdomain(2) != 'www' &&  request.subdomain(2) != 'butter' &&  request.subdomain(2) != 'badger'
  end  
end